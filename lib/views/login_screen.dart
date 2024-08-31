import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/config/localization/localications.dart';
import 'package:simple_auth/providers/user_provider.dart';
import 'package:simple_auth/routes/routes.dart';
import 'package:simple_auth/utils/check_device.dart';
import 'package:simple_auth/utils/secure_storage.dart';
import 'package:simple_auth/utils/theme_helper.dart';
import 'package:simple_auth/views/widgets/header_widget.dart';
import 'package:simple_auth/views/widgets/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _usernameHasError = false;
  bool _passwordHasError = false;

  late bool _canAskForFingerprint = false;
  late bool _useFingerPrintSwitch = false;

  final SecureStorage secureStorage = SecureStorage();

  void _loadData() async {
    bool isDeviceSafe = await checkDeviceIsSafe();
    if (!isDeviceSafe) {
      Navigator.pushReplacementNamed(context, Routes.deviceUnsafe);
    }

    try {
      if (kDebugMode) {
        print("** 1 checking can ask for fingerprint state");
      }
      var bool = await SecureStorage().getCanAskForFingerPrint();
      setState(() {
        _canAskForFingerprint = bool;
      });

      if (!_canAskForFingerprint) {
        if (kDebugMode) {
          print("** 1 can ask for fingerprint is false");
        }
      } else {
        if (kDebugMode) {
          print("** 1 can ask for fingerprint is true");
        }
      }

      if (kDebugMode) {
        print("** 1 checking use finger print switch state");
      }
      var bool2 = await SecureStorage().getUseFingerPrintSwitch();
      setState(() {
        _useFingerPrintSwitch = bool2;
      });
      if (!_useFingerPrintSwitch) {
        if (kDebugMode) {
          print("** 1 can use finger print switch is false");
        }
      } else {
        if (kDebugMode) {
          print("** 1 can use finger print switch is true");
        }
      }

      if (_canAskForFingerprint && _useFingerPrintSwitch) {
        if (kDebugMode) {
          print("** 1 CAN USE FINGERPRINT");
        }
      }
    } on Exception {
      if (kDebugMode) {
        print("** 1 Error reading data from secure storage");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    _usernameController.addListener(() {
      if (_usernameHasError) {
        setState(() {
          _usernameHasError = false;
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordHasError) {
        setState(() {
          _passwordHasError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (kDebugMode) {
      print('App state changed to: $state');
    }

    switch (state) {
      case AppLifecycleState.inactive:
        if (kDebugMode) {
          print('App is inactive.');
        }
        break;

      case AppLifecycleState.hidden:
        if (kDebugMode) {
          print('App is hidden. (All views of an application are hidden)');
        }
        _loadData();
        break;

      case AppLifecycleState.paused:
        if (kDebugMode) {
          print('App is paused (minimized or backgrounded).');
        }
        break;

      case AppLifecycleState.resumed:
        bool isDeviceSafe = await checkDeviceIsSafe();
        if (!isDeviceSafe) {
          Navigator.pushReplacementNamed(context, Routes.deviceUnsafe);
        }
        _loadData();
        if (kDebugMode) {
          print('App is resumed (foreground).');
        }
        break;

      case AppLifecycleState.detached:
        if (kDebugMode) {
          print('App is detached (about to be terminated).');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return LoadingOverlay(
        isLoading: userProvider.isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: _headerHeight,
                  child: HeaderWidget(
                      height: _headerHeight,
                      showIcon: true,
                      icon: Icons
                          .login_rounded), //let's create a common header widget
                ),
                SafeArea(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      // This will be the login form
                      child: Column(
                        children: [
                          Text(
                            locale!.translate('hello'),
                            style: const TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            locale.translate('w_message'),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            locale.translate('sign_account'),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 30.0),
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      controller: _usernameController,
                                      focusNode: _usernameFocusNode,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context)
                                            .requestFocus(_passwordFocusNode);
                                      },
                                      onChanged: (value) {
                                        _formKey.currentState?.validate();
                                      },
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              context,
                                              locale.translate('user_name'),
                                              locale
                                                  .translate('user_name_text'))
                                          .copyWith(
                                            errorMaxLines: 2,
                                            errorStyle: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return locale
                                              .translate('user_name_error');
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Container(
                                    decoration: ThemeHelper()
                                        .inputBoxDecorationShaddow(),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      onFieldSubmitted: (val) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (value) {
                                        _formKey.currentState?.validate();
                                      },
                                      obscureText: _isObscured,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              context,
                                              locale.translate('pass'),
                                              locale.translate('pass_text'))
                                          .copyWith(
                                            errorMaxLines: 2,
                                            errorStyle: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _isObscured
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscured =
                                                      !_isObscured; // Toggle the visibility state
                                                });
                                              },
                                            ),
                                          ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return locale.translate('pass_error');
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 50.0),
                                  Container(
                                    decoration: ThemeHelper()
                                        .buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            40, 10, 40, 10),
                                        child: Text(
                                          locale
                                              .translate('sign_in')
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          await onLoginClicked(
                                              userProvider, locale);
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 5),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: locale.translate('no_account')),
                                      TextSpan(
                                        text: locale.translate('create'),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, Routes.register);
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                    ])),
                                  ),
                                  Visibility(
                                    visible: _canAskForFingerprint,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {
                                          onBiometricsClicked(
                                              userProvider, locale);
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.fingerprint,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> onBiometricsClicked(UserProvider userProvider, locale) async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool hasBiometrics = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !hasBiometrics) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            content: Text(
              locale.translate('biometric_not_available'),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
        if (kDebugMode) {
          print('Biometric authentication is not available on this device');
        }
        return;
      } else {
        if (kDebugMode) {
          print('Biometric authentication is available');
        }
      }

      bool isAuthenticated = false;
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to log in',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        if (kDebugMode) {
          print('Authentication successful');
        }

        var login = await userProvider.getUser();
        if (login != null) {
          if (kDebugMode) {
            print(login);
          }

          if (!_useFingerPrintSwitch) {
            await SecureStorage().saveUseFingerPrintSwitch(true);
          }

          Navigator.pushReplacementNamed(context, Routes.profile,
              arguments: {'user': userProvider.user});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              content: Text(
                locale.translate('success'),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                locale.translate('auth_failed_try_later'),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      } else {
        if (kDebugMode) {
          print('Authentication failed');
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: Text(
            locale.translate('auth_failed'),
            style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold),
          ),
        ));
      }
    } catch (e) {
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        content: Text(
          locale.translate('auth_failed'),
          style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Future<void> onLoginClicked(userProvider, locale) async {
    final String userName = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (kDebugMode) {
      print('username: $userName');
      print('password: $password');
    }

    var login = await userProvider.loginUser(userName, password);
    if (login) {
      Navigator.pushReplacementNamed(context, Routes.profile,
          arguments: {'user': userProvider.user});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          content: Text(
            locale.translate('success'),
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: Text(
            locale.translate('invalid_cred'),
            style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
