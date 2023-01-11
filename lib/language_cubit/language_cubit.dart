import 'package:asrar_app/core/app/language.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState());

  void setArabic() {
    emit(const LanguageState(locale: arabicLocale));
  }

  void setEnglish() {
    emit(const LanguageState(locale: englishLocale));
  }
}
