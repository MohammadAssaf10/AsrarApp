import 'package:asrar_app/core/app/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/strings_manager.dart';

const String prefsKeyLang = "PREFS_KEY_LANG";
const Locale arabicLocale = Locale("ar");
const Locale englishLocale = Locale("en");

Locale getLocal() {
  final String? language =
      instance<SharedPreferences>().getString(prefsKeyLang);
  if (language == AppStrings.arabic) {
    return arabicLocale;
  } else {
    return englishLocale;
  }
}
