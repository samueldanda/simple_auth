import 'db.dart';

class SecureStorage {
  // Keys
  static const String _themeKey = 'app_theme_mode';
  static const String _keySelectedLocale = 'selected_locale';
  static const String _canAskForFingerPrintKey = 'user_has_logged_in';
  static const String _useFingerPrintSwitchKey = 'use_finger_print_switch';
  static const String _useEnglishSwitchKey = 'use_english_switch';
  static const String _useLightThemeSwitchKey = 'use_light_theme_switch';

  Future<void> saveTheme(int theme) async {
    await DatabaseHelper.db.saveKeyValue(_themeKey, theme.toString());
  }

  Future<int> getTheme() async {
    String? themeString = await DatabaseHelper.db.getValueForKey(_themeKey);
    return themeString != null ? int.tryParse(themeString) ?? 1 : 1;
  }

  Future<void> saveCanAskForFingerPrint(bool value) async {
    await DatabaseHelper.db.saveKeyValue(_canAskForFingerPrintKey, value.toString());
  }

  Future<bool> getCanAskForFingerPrint() async {
    String? value = await DatabaseHelper.db.getValueForKey(_canAskForFingerPrintKey);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  Future<void> saveUseFingerPrintSwitch(bool value) async {
    await DatabaseHelper.db.saveKeyValue(_useFingerPrintSwitchKey, value.toString());
  }

  Future<bool> getUseFingerPrintSwitch() async {
    String? value = await DatabaseHelper.db.getValueForKey(_useFingerPrintSwitchKey);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  Future<void> saveUseEnglishSwitch(bool value) async {
    await DatabaseHelper.db.saveKeyValue(_useEnglishSwitchKey, value.toString());
  }

  Future<bool> getUseEnglishSwitch() async {
    String? value = await DatabaseHelper.db.getValueForKey(_useEnglishSwitchKey);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  Future<void> saveUseLightThemeSwitch(bool value) async {
    await DatabaseHelper.db.saveKeyValue(_useLightThemeSwitchKey, value.toString());
  }

  Future<bool> getUseLightThemeSwitch() async {
    String? value = await DatabaseHelper.db.getValueForKey(_useLightThemeSwitchKey);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  Future<void> logout() async {
    await DatabaseHelper.db.deleteKey(_canAskForFingerPrintKey);
    await DatabaseHelper.db.deleteKey(_useFingerPrintSwitchKey);
  }
}
