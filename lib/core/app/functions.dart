import 'dart:math';

import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../config/color_manager.dart';
import '../../config/strings_manager.dart';
import '../../config/styles_manager.dart';
import '../../config/values_manager.dart';
import '../../features/home/presentation/widgets/home_button_widgets.dart';
import '../../core/app/extensions.dart';

String? nameValidator(String? name, BuildContext context) {
  if (name.nullOrEmpty()) {
    return ""; //AppStrings.pleaseEnterName.tr(context);
  }

  if (name!.length < 3) {
    return ""; //AppStrings.nameTooShort.tr(context);
  }

  return null;
}

String? mobileNumberValidator(String? phone, BuildContext context) {
  if (phone.nullOrEmpty()) {
    return ""; //AppStrings.pleaseEnterName.tr(context);
  }

  if (!isMobileNumberCorrect(phone!)) {
    return AppStrings.mobileNumberFormatNotCorrect.tr(context);
  }

  return null;
}

String? emailValidator(String? email, BuildContext context) {
  if (email.nullOrEmpty()) {
    return AppStrings.pleaseEnterEmail.tr(context);
  }

  if (!isEmailFormatCorrect(email!)) {
    return AppStrings.emailFormatNotCorrect.tr(context);
  }

  return null;
}

String? cantBeEmpty(String? v, BuildContext context) {
  if (v.nullOrEmpty()) {
    return '';
  }

  return null;
}

bool isEmailFormatCorrect(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isMobileNumberCorrect(String mobileNumber) {
  return RegExp(r"^[+]*[0-9]+").hasMatch(mobileNumber);
}

///places: The desired number of digits after the comma
double dp(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

double stringToDouble(String str) {
  return double.parse(str);
}

_isCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

void showCustomDialog(BuildContext context,
    {String? message, String? jsonPath}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    dismissDialog(context);
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: EdgeInsets.all(AppSize.s8.h),
          child: Card(
            color: ColorManager.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (jsonPath != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s10.h,
                      horizontal: AppSize.s10.w,
                    ),
                    child: Lottie.asset(jsonPath),
                  ),
                if (message != null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s10.h,
                      horizontal: AppSize.s10.w,
                    ),
                    child: Center(
                      child: Text(
                        message,
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s16.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                if (jsonPath == null && message == null)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s8.h,
                      horizontal: AppSize.s8.w,
                    ),
                    child: const CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

void showOrderDialog(
  BuildContext context,
  String title,
  String number,
  String totalPrice,
  Function acceptOnTap,
) {
  dismissDialog(context);
  TextEditingController controller = TextEditingController();
  controller = TextEditingController(text: number);

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          "${AppStrings.totalPrice.tr(context)}: $totalPrice ر.س",
          style: getAlmaraiRegularStyle(
            fontSize: AppSize.s20.sp,
            color: ColorManager.primary,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s20.sp,
                    color: ColorManager.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.s5.h),
              TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[0-9]"),
                  ),
                ],
                decoration: InputDecoration(
                  hintText: title,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO:when finish app changer 10 to 9
                OptionButton(
                  onTap: () {
                    if (controller.text.isNotEmpty &&
                        controller.text.length == 10) acceptOnTap();
                  },
                  title: AppStrings.checkout.tr(context),
                  height: AppSize.s35.h,
                  width: AppSize.s110.w,
                  fontSize: AppSize.s18.sp,
                ),
                SizedBox(
                  width: AppSize.s5.w,
                ),
                OptionButton(
                  onTap: () {
                    dismissDialog(context);
                  },
                  title: AppStrings.cancel.tr(context),
                  height: AppSize.s35.h,
                  width: AppSize.s110.w,
                  fontSize: AppSize.s20.sp,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
