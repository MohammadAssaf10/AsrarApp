import 'package:asrar_app/config/routes_manager.dart';
import 'package:asrar_app/core/app/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_localizations.dart';
import '../../config/theme_manager.dart';

class MyApp extends StatelessWidget {
  // named constructor
  const MyApp._internal();

  static const MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "أسرار",
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [arabicLocale, englishLocale],
          locale: arabicLocale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: getApplicationTheme(),
          initialRoute: Routes.homeRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}
