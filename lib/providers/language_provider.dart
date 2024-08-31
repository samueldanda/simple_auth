import 'package:flutter/material.dart';
import 'package:simple_auth/utils/secure_storage.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  LanguageProvider() {
    _loadLocale();
  }

  Locale get locale => _locale;

  bool get isEnglish => _locale == const Locale('en');

  Future<void> _loadLocale() async {
    final prefs = SecureStorage();
    final useEnglish = await prefs.getUseEnglishSwitch();
    _locale = Locale(useEnglish ? 'en' : 'sw');
    notifyListeners();
  }

  Future<void> setEnglish() async {
    _locale = const Locale('en');
    await _saveLocale();
    notifyListeners();
  }

  Future<void> setSwahili() async {
    _locale = const Locale('sw');
    await _saveLocale();
    notifyListeners();
  }

  Future<void> _saveLocale() async {
    final prefs = SecureStorage();
    await prefs.saveUseEnglishSwitch(_locale.languageCode == 'en');
  }
}
