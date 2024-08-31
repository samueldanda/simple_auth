import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
    final _storage = const FlutterSecureStorage();

    // Keys
    static const String _themeKey = 'app_theme_mode';
    static const String _keySelectedLocale = 'selected_locale';
    static const String _canAskForFingerPrintKey = 'user_has_logged_in';
    static const String _useFingerPrintSwitchKey = 'use_finger_print_switch';
    static const String _useEnglishSwitchKey = 'use_english_switch';
    static const String _useLightThemeSwitchKey = 'use_light_theme_switch';

    Future<void> saveTheme(int theme) async {
      await _storage.write(key: _themeKey, value: theme.toString());
    }

    Future<int> getTheme() async {
      String? step = await _storage.read(key: _themeKey);
      return step != null ? int.tryParse(step) ?? 1 : 1;
    }

    Future<void> saveCanAskForFingerPrint(bool value) async {
      await _storage.write(key: _canAskForFingerPrintKey, value: value.toString());
    }

    Future<bool> getCanAskForFingerPrint() async {
      String? value = await _storage.read(key: _canAskForFingerPrintKey);
      return value != null ? value.toLowerCase() == 'true' : false;
    }

    Future<void> saveUseFingerPrintSwitch(bool value) async {
      await _storage.write(key: _useFingerPrintSwitchKey, value: value.toString());
    }

    Future<bool> getUseFingerPrintSwitch() async {
      String? value = await _storage.read(key: _useFingerPrintSwitchKey);
      return value != null ? value.toLowerCase() == 'true' : false;
    }

    Future<void> saveUseEnglishSwitch(bool value) async {
      await _storage.write(key: _useEnglishSwitchKey, value: value.toString());
    }

    Future<bool> getUseEnglishSwitch() async {
      String? value = await _storage.read(key: _useEnglishSwitchKey);
      return value != null ? value.toLowerCase() == 'true' : false;
    }

    Future<void> saveUseLightThemeSwitch(bool value) async {
      await _storage.write(key: _useLightThemeSwitchKey, value: value.toString());
    }

    Future<bool> getUseLightThemeSwitch() async {
      String? value = await _storage.read(key: _useLightThemeSwitchKey);
      return value != null ? value.toLowerCase() == 'true' : false;
    }

    Future<void> logout() async {
      await _storage.delete(key: _canAskForFingerPrintKey);
      await _storage.delete(key: _useFingerPrintSwitchKey);
    }
}
