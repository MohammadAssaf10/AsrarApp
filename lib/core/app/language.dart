import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageType { english, arabic }

const String prefsKeyLang = "PREFS_KEY_LANG";
const String arabic = "ar";
const String english = "en";
const Locale arabicLocal = Locale("ar");
const Locale englishLocal = Locale("en");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}

class LanguageCacheHelper {
  final SharedPreferences _sharedPreferences;

  LanguageCacheHelper(this._sharedPreferences);

  void cachedLanguageCode(String languageCode) {
    _sharedPreferences.setString(prefsKeyLang, languageCode);
  }

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.arabic.getValue();
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = await getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocal;
    } else {
      return englishLocal;
    }
  }
}
