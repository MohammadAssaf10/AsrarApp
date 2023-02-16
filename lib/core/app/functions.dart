import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'package:asrar_app/config/app_localizations.dart';

import '../../config/color_manager.dart';
import '../../config/strings_manager.dart';
import '../../config/styles_manager.dart';
import '../../config/values_manager.dart';
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

RegExp getNumberInputFormat() {
  return RegExp(r'^[0-9]+');
}

RegExp getDoubleInputFormat() {
  return RegExp(r'(^\d*\.?\d*)');
}

RegExp getTextWithNumberInputFormat() {
  return RegExp(r"^[a-zA-Z0-9ء-ي\s]+");
}

RegExp getArabicAndEnglishTextInputFormat() {
  return RegExp(r"^[a-zA-Zء-ي\s]+");
}

RegExp getAllKeyboradInputFormat() {
  return RegExp(r"^([،a-zA-Z\u0020-\u007Eء-ي\n]+)");
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
      builder: (_) => Dialog(
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
    );
  });
}

Future<bool> showConfirmDialog(BuildContext context,
    {String? text,
    Function? executeWhenConfirm,
    Function? executeWhenCancel}) async {
  bool confirm = false;

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text?.tr(context) ?? '${AppStrings.confirm.tr(context)}?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: AppSize.s10.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      confirm = true;
                      if (executeWhenConfirm != null) executeWhenConfirm();
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings.confirm.tr(context)),
                  ),
                  SizedBox(width: AppSize.s10.h),
                  OutlinedButton(
                    onPressed: () {
                      confirm = false;
                      if (executeWhenCancel != null) executeWhenCancel();
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings.cancel.tr(context)),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return confirm;
}

final String serverKey =
    'AAAAcsoR5BA:APA91bErG1Nb6XMvRUERMyZ7TOD3X7XspXJNeiDvGbsRKH7vfT0TFfQo1oFzZJRIhfBEzvv4gxqJ5GX9DXG9zDOqxJbHhd4YZPvKCRtlhRaGgYnfJkqC2rRgR358YIIHLYh01rdf8zns';
// Create a FirebaseMessaging instance
Future<void> sendNotificationToUser(
    String token, String title, String nMessage) async {
  try {
    // Create a FirebaseMessaging instance
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Set the server key for FCM
    await messaging.requestPermission();
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Define the message to send
    var message = {
      'notification': {
        'title': title,
        'body': nMessage,
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done'
      },
      'to': token
    };

    // Send the message to the FCM API
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(message),
    );
    print("Notification sent successfully");
  } catch (e) {
    print('Error sending notification: $e');
  }
}
