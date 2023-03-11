import 'package:asrar_app/core/app/language.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/strings_manager.dart';
import '../core/app/di.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  void setArabic() {
    instance<SharedPreferences>().setString(prefsKeyLang, AppStrings.arabic);
    emit(const LanguageState(locale: arabicLocale));
  }

  void setEnglish() {
    instance<SharedPreferences>().setString(prefsKeyLang, AppStrings.english);
    emit(const LanguageState(locale: englishLocale));
  }
}
