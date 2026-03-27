import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider(this.prefs) {
    _loadStoredLocale();
  }

  // Set new language and save to disk
  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    await prefs.setString('language_code', locale.languageCode);
  }

  // Load the language when app starts
  void _loadStoredLocale() async {
    String? code = prefs.getString('language_code');
    if (code != null) {
      _locale = Locale(code);
      notifyListeners();
    } else {
      // If no language is saved, default to English
      _locale = const Locale('en');
      notifyListeners();
    }
  }
  // FOR FUTURE USE
  //   void _loadStoredLocale() {
  //   String? code = prefs.getString('language_code');

  //   if (code != null) {
  //     _locale = Locale(code);
  //   } else {
  //     // 1. Get the device's current language (e.g., 'hi' or 'en')
  //     final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  //     // 2. Define your list of 15-20 supported codes
  //     const supportedCodes = ['en', 'hi', 'mr', 'es', 'fr'];

  //     // 3. If the device language is in your supported list, use it.
  //     // Otherwise, default to English.
  //     if (supportedCodes.contains(deviceLocale)) {
  //       _locale = Locale(deviceLocale);
  //     } else {
  //       _locale = const Locale('en');
  //     }
  //   }
  //   notifyListeners();
  // }
}
