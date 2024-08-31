import 'package:flutter/material.dart';
import 'package:simple_auth/utils/secure_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default to light theme

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadThemeMode() async {
    final prefs = SecureStorage();
    final themeIndex = await prefs.getTheme();
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  Future<void> setLightTheme() async {
    _themeMode = ThemeMode.light;
    await _saveThemeMode();
    notifyListeners();
  }

  Future<void> setDarkTheme() async {
    _themeMode = ThemeMode.dark;
    await _saveThemeMode();
    notifyListeners();
  }

  Future<void> setCustomTheme(int themeIndex) async {
    if (themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[themeIndex];
      await _saveThemeMode();
      notifyListeners();
    }
  }

  Future<void> _saveThemeMode() async {
    final prefs = SecureStorage();
    await prefs.saveTheme(_themeMode.index);
  }
}
