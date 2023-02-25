import 'package:asrar_app/config/styles_manager.dart';
import 'package:asrar_app/config/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.backgroundColor,
    // app bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light),
      centerTitle: true,
      elevation: AppSize.s0,
      titleTextStyle: getAlmaraiRegularStyle(
          fontSize: AppSize.s17.sp, color: ColorManager.white),
    ),

    errorColor: ColorManager.error,

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionHandleColor: ColorManager.primary,
    ),

    textTheme: TextTheme(
      subtitle1: getAlmaraiRegularStyle(
        fontSize: AppSize.s18.sp,
        color: ColorManager.primary,
      ),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // hint style
      hintStyle: getAlmaraiRegularStyle(
          color: ColorManager.darkPrimary, fontSize: AppSize.s16.sp),
      labelStyle: getAlmaraiRegularStyle(
          color: ColorManager.darkPrimary, fontSize: AppSize.s16.sp),
      errorStyle: getAlmaraiRegularStyle(
          color: ColorManager.error, fontSize: AppSize.s14.sp),
      suffixIconColor: ColorManager.primary,
      border: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5.w),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s18.r),
        ),
      ),
      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5.w),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s18.r),
        ),
      ),
      // focused border style
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5.w),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s18.r),
        ),
      ),
      // error border style
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.error),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s18.r),
        ),
      ),
      // focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.error),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s18.r),
        ),
      ),
    ),
    // icon theme
    iconTheme: IconThemeData(color: ColorManager.white, size: AppSize.s25.sp),
    // text button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorManager.grey;
            } else {
              return ColorManager.primary;
            }
          },
        ),
        textStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return getAlmaraiRegularStyle(
                color: ColorManager.grey, fontSize: AppSize.s18.sp);
          } else {
            return getAlmaraiRegularStyle(
                color: ColorManager.primary, fontSize: AppSize.s18.sp);
          }
        }),
      ),
    ),
    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorManager.white;
          } else {
            return ColorManager.primary;
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorManager.primary;
          } else {
            return ColorManager.white;
          }
        }),
        shadowColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorManager.white;
          } else {
            return ColorManager.primary;
          }
        }),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return AppSize.s0;
          } else {
            return AppSize.s6.h;
          }
        }),
        side: MaterialStateProperty.resolveWith(
            (states) => const BorderSide(color: ColorManager.primary)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s20.r),
          ),
        ),
      ),
    ),
    // outline button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorManager.primary;
            } else {
              return ColorManager.white;
            }
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorManager.white;
            } else {
              return ColorManager.primary;
            }
          }),
          side: MaterialStateProperty.resolveWith(
              (states) => const BorderSide(color: ColorManager.primary)),
          elevation: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppSize.s0;
            } else {
              return AppSize.s6.h;
            }
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return ColorManager.white;
            } else {
              return ColorManager.primary;
            }
          }),
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s18));
          })),
    ),
  );
}
