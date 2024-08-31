import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth/config/localization/localications.dart';
import 'package:simple_auth/routes/routes.dart';
import 'package:simple_auth/utils/theme_helper.dart';
import 'package:simple_auth/views/widgets/header_widget.dart';
import 'package:simple_auth/views/widgets/loading_overlay.dart';

import '../providers/user_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  bool _isObscured = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _mobileNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _firstNameHasError = false;
  bool _lastNameHasError = false;
  bool _mobileNumberHasError = false;
  bool _passwordHasError = false;

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(() {
      if (_firstNameHasError) {
        setState(() {
          _firstNameHasError = false;
        });
      }
    });

    _lastNameController.addListener(() {
      if (_lastNameHasError) {
        setState(() {
          _lastNameHasError = false;
        });
      }
    });

    _emailController.addListener(() {
      if (_emailFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });

    _mobileNumberController.addListener(() {
      if (_mobileNumberHasError) {
        setState(() {
          _mobileNumberHasError = false;
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return LoadingOverlay(
        isLoading: userProvider.isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                const SizedBox(
                  height: 150,
                  child: HeaderWidget(
                      height: 150,
                      showIcon: false,
                      icon: Icons.person_add_alt_1_rounded),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
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
                                      color: Colors.grey.shade300,
                                      size: 80.0,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(80, 80, 0, 0),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.grey.shade700,
                                      size: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _firstNameController,
                                focusNode: _firstNameFocusNode,
                                decoration: ThemeHelper()
                                    .textInputDecoration(
                                        context,
                                        locale!.translate('first_name'),
                                        locale.translate('first_name_text'))
                                    .copyWith(
                                      errorMaxLines: 2,
                                      errorStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return locale.translate('first_name_error');
                                  } else if (val.length < 3) {
                                    return locale.translate(
                                        'first_name_min_length_error');
                                  } else if (!RegExp(r"^[a-zA-Z-' ]+$")
                                      .hasMatch(val)) {
                                    return locale.translate(
                                        'first_name_invalid_chars_error');
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_lastNameFocusNode);
                                },
                                onChanged: (value) {
                                  _formKey.currentState?.validate();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _lastNameController,
                                focusNode: _lastNameFocusNode,
                                decoration: ThemeHelper()
                                    .textInputDecoration(
                                        context,
                                        locale.translate('last_name'),
                                        locale.translate('last_name_text'))
                                    .copyWith(
                                      errorMaxLines: 2,
                                      errorStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return locale.translate('last_name_error');
                                  } else if (val.length < 3) {
                                    return locale.translate(
                                        'last_name_min_length_error');
                                  } else if (!RegExp(r"^[a-zA-Z-' ]+$")
                                      .hasMatch(val)) {
                                    return locale.translate(
                                        'last_name_invalid_chars_error');
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocusNode);
                                },
                                onChanged: (value) {
                                  _formKey.currentState?.validate();
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                decoration: ThemeHelper()
                                    .textInputDecoration(
                                        context,
                                        locale.translate('email_'),
                                        locale.translate('email_text'))
                                    .copyWith(
                                      errorMaxLines: 2,
                                      errorStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return locale.translate('email_error');
                                  }

                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                    return locale.translate('email_error2');
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_mobileNumberFocusNode);
                                },
                                onChanged: (value) {
                                  if (_emailFocusNode.hasFocus) {
                                    _formKey.currentState?.validate();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _mobileNumberController,
                                focusNode: _mobileNumberFocusNode,
                                decoration: ThemeHelper()
                                    .textInputDecoration(
                                        context,
                                        locale.translate('phone_'),
                                        locale.translate('phone_text'))
                                    .copyWith(
                                      errorMaxLines: 2,
                                      errorStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                keyboardType: TextInputType.phone,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return locale.translate('phone_error');
                                  }

                                  if (!RegExp(r"^0(6|7|5)\d{8}$")
                                      .hasMatch(val)) {
                                    return locale.translate('phone_error2');
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                onChanged: (value) {
                                  _formKey.currentState?.validate();
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                              child: TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                obscureText: _isObscured,
                                decoration: ThemeHelper()
                                    .textInputDecoration(
                                        context,
                                        locale.translate('password'),
                                        locale.translate('password_text'))
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
                                    return locale.translate('password_error');
                                  } else if (val.length < 8) {
                                    return locale
                                        .translate('password_min_length_error');
                                  } else if (!RegExp(r'[A-Z]').hasMatch(val)) {
                                    return locale
                                        .translate('password_uppercase_error');
                                  } else if (!RegExp(r'[a-z]').hasMatch(val)) {
                                    return locale
                                        .translate('password_lowercase_error');
                                  } else if (!RegExp(r'[0-9]').hasMatch(val)) {
                                    return locale
                                        .translate('password_digit_error');
                                  } else if (!RegExp(r'[!@#\$&*~]')
                                      .hasMatch(val)) {
                                    return locale.translate(
                                        'password_special_char_error');
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value) {
                                  _formKey.currentState?.validate();
                                  // _formKey.currentState?.validate();
                                },
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            FormField<bool>(
                              builder: (state) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                            value: checkboxValue,
                                            onChanged: (value) {
                                              setState(() {
                                                checkboxValue = value!;
                                                state.didChange(value);
                                              });
                                            }),
                                        Text(
                                          locale.translate('terms'),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.errorText ?? '',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                              validator: (value) {
                                if (!checkboxValue) {
                                  return locale.translate('terms_error');
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    locale.translate('register').toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    await onRegisterClicked(
                                        userProvider, locale);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              locale.translate('or'),
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: const FaIcon(
                                    FontAwesomeIcons.googlePlus,
                                    size: 35,
                                    color: Color.fromRGBO(236, 45, 47, 1.0),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alertDialog(
                                              'Google Plus',
                                              locale.translate('google_tap'),
                                              context);
                                        },
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5,
                                          color: const Color.fromRGBO(
                                              64, 171, 240, 1.0)),
                                      color: const Color.fromRGBO(
                                          64, 171, 240, 1.0),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.twitter,
                                      size: 23,
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alertDialog(
                                              'Twitter',
                                              locale.translate('twitter_tap'),
                                              context);
                                        },
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                GestureDetector(
                                  child: const FaIcon(
                                    FontAwesomeIcons.facebook,
                                    size: 35,
                                    color: Color.fromRGBO(62, 82, 156, 1.0),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alertDialog(
                                              'Facebook',
                                              locale.translate('facebook_tap'),
                                              context);
                                        },
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> onRegisterClicked(userProvider, locale) async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String email = _emailController.text.trim();
    final String mobileNumber = _mobileNumberController.text.trim();
    final String password = _passwordController.text.trim();

    if (kDebugMode) {
      print('firstName: $firstName');
      print('lastName: $lastName');
      print('email: $email');
      print('mobileNumber: $mobileNumber');
      print('password: $password');
    }

    var register = await userProvider.registerUser(
        firstName, lastName, email, mobileNumber, password);
    if (register) {
      Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          content: Text(
            locale.translate('user_created'),
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
