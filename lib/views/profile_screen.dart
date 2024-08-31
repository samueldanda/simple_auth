import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_auth/providers/language_provider.dart';
import 'package:simple_auth/providers/theme_provider.dart';
import 'package:simple_auth/routes/routes.dart';
import 'package:simple_auth/utils/check_device.dart';
import 'package:simple_auth/utils/secure_storage.dart';
import 'package:simple_auth/views/widgets/header_widget.dart';

import '../config/localization/localications.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late ThemeProvider _themeProvider;
  late LanguageProvider _languageProvider;

  final double _drawerIconSize = 20;
  final double _drawerFontSize = 14;

  bool _isEnglishLanguage = false;
  bool _isDarkTheme = false;

  // bool _useFingerprint = false;

  late bool _canAskForFingerprint = false;
  late bool _useFingerPrintSwitch = false;

  final SecureStorage secureStorage = SecureStorage();

  void _loadData() async {
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    _isEnglishLanguage = _languageProvider.isEnglish;
    _isDarkTheme = _themeProvider.isDarkMode;

    try {
      if (kDebugMode) {
        print("** 2 checking can ask for fingerprint state");
      }
      var bool = await SecureStorage().getCanAskForFingerPrint();
      setState(() {
        _canAskForFingerprint = bool;
      });

      if (!_canAskForFingerprint) {
        if (kDebugMode) {
          print("** 2 can ask for fingerprint is false");
        }
        if (kDebugMode) {
          print("** 2 setting can ask for fingerprint to true");
        }
        await SecureStorage().saveCanAskForFingerPrint(true);
      } else {
        if (kDebugMode) {
          print("** 2 can ask for fingerprint is true");
        }
      }

      if (kDebugMode) {
        print("** 2 checking use finger print switch state");
      }
      var bool2 = await SecureStorage().getUseFingerPrintSwitch();
      setState(() {
        _useFingerPrintSwitch = bool2;
      });

      if (!_useFingerPrintSwitch) {
        if (kDebugMode) {
          print("** 2 can use finger print switch is false");
        }
      } else {
        if (kDebugMode) {
          print("** 2 can use finger print switch is true");
        }
      }
    } on Exception {
      if (kDebugMode) {
        print("** 2 Error reading data from secure storage");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.login, (route) => false);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.translate('profile_page_title'),
          style: TextStyle(
              color: Theme.of(context).colorScheme.primaryFixed,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.primaryFixed),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).colorScheme.onPrimaryFixedVariant,
                Theme.of(context).primaryColor.withOpacity(0.7),
              ])),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications,
                    color: Theme.of(context).colorScheme.primaryFixed),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [
                Theme.of(context)
                    .colorScheme
                    .onPrimaryFixedVariant
                    .withOpacity(0.2),
                Theme.of(context).primaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          locale.translate('app_name'),
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        height: 42,
                        width: 42,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ),
                        child: Icon(
                          Icons.fingerprint_rounded,
                          size: _drawerIconSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        locale.translate('bio_title'),
                        style: TextStyle(
                          fontSize: _drawerFontSize,
                        ),
                      ),
                      trailing: Switch(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        value: _useFingerPrintSwitch,
                        onChanged: (bool value) async {
                          final LocalAuthentication auth =
                              LocalAuthentication();
                          bool canCheckBiometrics =
                              await auth.canCheckBiometrics;
                          bool hasBiometrics = await auth.isDeviceSupported();

                          if (!canCheckBiometrics || !hasBiometrics) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                content: Text(
                                  locale.translate(
                                      'bio_not_available_or_enabled'),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            if (kDebugMode) {
                              print(locale.translate('bio_not_available'));
                            }
                            return;
                          } else {
                            if (kDebugMode) {
                              print('Biometric authentication is available');
                            }
                          }

                          bool isAuthenticated = false;
                          isAuthenticated = await auth.authenticate(
                            localizedReason: value
                                ? 'Please authenticate to switch on'
                                : 'Please authenticate to switch of',
                            options: const AuthenticationOptions(
                              biometricOnly: true,
                            ),
                          );

                          if (isAuthenticated) {
                            if (kDebugMode) {
                              print('Authentication successful');
                            }

                            if (value) {
                              await secureStorage
                                  .saveUseFingerPrintSwitch(true);
                              await secureStorage
                                  .saveCanAskForFingerPrint(true);
                            } else {
                              await secureStorage
                                  .saveUseFingerPrintSwitch(false);
                              await secureStorage
                                  .saveCanAskForFingerPrint(false);
                            }

                            setState(() {
                              _useFingerPrintSwitch = value;
                            });
                          } else {
                            if (kDebugMode) {
                              print('Authentication failed');
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              content: Text(
                                locale.translate('auth_failed'),
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.bold),
                              ),
                            ));
                          }
                        },
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        height: 42,
                        width: 42,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ),
                        child: _isEnglishLanguage
                            ? Image.asset(
                                'assets/flags/uk_flag.png') // English flag icon
                            : Image.asset(
                                'assets/flags/tz_flag.png'), // Swahili flag icon
                      ),
                      title: Text(
                        locale.translate('change_lang'),
                        style: TextStyle(
                          fontSize: _drawerFontSize,
                        ),
                      ),
                      trailing: Switch(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        value: _isEnglishLanguage,
                        onChanged: (bool value) {
                          if (value) {
                            _languageProvider.setEnglish();
                          } else {
                            _languageProvider.setSwahili();
                          }
                          setState(() {
                            _isEnglishLanguage = _languageProvider.isEnglish;
                          });
                        },
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        height: 42,
                        width: 42,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ),
                        child: Icon(
                          _isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                          // Theme icon
                          size: _drawerIconSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        locale.translate('change_theme'),
                        style: TextStyle(
                          fontSize: _drawerFontSize,
                        ),
                      ),
                      trailing: Switch(
                        inactiveThumbColor:
                            Theme.of(context).colorScheme.primary,
                        value: _isDarkTheme,
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              // Switch is ON (Dark Theme)
                              _themeProvider.setDarkTheme();
                              _isDarkTheme = true;
                            } else {
                              // Switch is OFF (Light Theme)
                              _themeProvider.setLightTheme();
                              _isDarkTheme = false;
                            }
                          });
                        },
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Container(
                        height: 42,
                        width: 42,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ),
                        child: Icon(
                          Icons.share,
                          size: _drawerIconSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        locale.translate('share_app'),
                        style: TextStyle(
                          fontSize: _drawerFontSize,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: _drawerIconSize,
                      ),
                      onTap: () {
                        String appDownloadLink =
                            'https://samdevlab.com/files/simpleAuth.apk';

                        final String message = '''
Discover SimpleAuth - Your go-to app for seamless and secure authentication. 
Click the link below to download and start your journey:
$appDownloadLink
''';
                        Share.share(message,
                            subject: 'Download SimpleAuth App');
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Container(
                  height: 42,
                  width: 42,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.4),
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  locale.translate('logout'),
                  style: TextStyle(
                    fontSize: _drawerFontSize,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: _drawerIconSize,
                ),
                onTap: () async {
                  await SecureStorage().logout();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(
                  height: 100, showIcon: false, icon: Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 5,
                          color: Theme.of(context).colorScheme.onPrimary),
                      color: Theme.of(context).colorScheme.onPrimary,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.translate('welcome'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user['firstName'] + ' ' + widget.user['lastName'],
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Center(
                            child: Text(
                              locale.translate('user_info'),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          leading: const Icon(Icons.person),
                                          title:
                                              Text(locale.translate('f_name')),
                                          subtitle:
                                              Text(widget.user['firstName']),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.person),
                                          title:
                                              Text(locale.translate('l_name')),
                                          subtitle:
                                              Text(widget.user['lastName']),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.email),
                                          title:
                                              Text(locale.translate('email')),
                                          subtitle: Text(widget.user['email']),
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.phone),
                                          title:
                                              Text(locale.translate('phone')),
                                          subtitle:
                                              Text(widget.user['mobileNumber']),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
