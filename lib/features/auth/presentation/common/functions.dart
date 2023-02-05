import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/app_localizations.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../bloc/authentication_bloc.dart';
import 'widgets/widgets.dart';

ShapeBorder roundedBorder({double radius = 30}) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.r));

manageDialog(BuildContext context, AuthenticationState state) async {
  if (state.status == AuthStatus.loading) {
    showCustomDialog(context);
  } else if (state.status == AuthStatus.failed) {
    showCustomDialog(context,
        jsonPath: JsonAssets.error, message: state.message!.tr(context));
  } else if (state.status == AuthStatus.loggedIn) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dismissDialog(context);
      // TODO: navigate to main view
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    });
  } else if (state.status == AuthStatus.resetPasswordSent) {
    showCustomDialog(context, message: AppStrings.resetEmailSendMessage);
  } else if (state.status == AuthStatus.verificationCodeNeeded) {
    Navigator.pushNamed(context, Routes.verificationView);
  } else if (state.status == AuthStatus.phoneNumberNeeded) {
    dismissDialog(context);

    final phoneNumber = await phoneDialog(context);
    if (phoneNumber.isNotEmpty)
      BlocProvider.of<AuthenticationBloc>(context)
          .add(MobileNumberEntered(mobileNumber: phoneNumber));
  }
}

Future<String> phoneDialog(BuildContext context) async {
  String _phoneNumber = '';
  String _countryCode = '';
  GlobalKey<FormState> _key = GlobalKey();

  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.enterYourWhatsappNumber.tr(context),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  AppStrings.includingCountryCodeLike.tr(context),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: AppSize.s10.h),
                Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.always,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: AppStrings.mobileNumber.tr(context),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      _countryCode = phone.countryCode;
                      _phoneNumber = phone.number;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FullElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) Navigator.pop(context);
                    },
                    text: AppStrings.sendVerificationCode.tr(context))
              ],
            ),
          ),
        );
      });
  if (_phoneNumber[0] == '0') {
    _phoneNumber = _phoneNumber.replaceFirst('0', '');
  }

  _phoneNumber = _countryCode + _phoneNumber;
  return _phoneNumber
      .replaceAll(' ', '')
      .replaceAll('-', '')
      .replaceAll('+', '');
}
