import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/scheduler.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/app_localizations.dart';
import '../../../../core/app/functions.dart';
import '../bloc/authentication_bloc.dart';
import 'widgets/widgets.dart';

ShapeBorder roundedBorder({double radius = 30}) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.r));

manageDialog(BuildContext context, AuthenticationState state) async {
  if (state is AuthenticationInProgress) {
    showCustomDialog(context);
  } else if (state is AuthenticationFailed) {
    showCustomDialog(context,
        jsonPath: JsonAssets.error, message: state.message.tr(context));
  } else if (state is AuthenticationSuccess) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dismissDialog(context);
      // TODO: navigate to main view
      Navigator.pushReplacementNamed(context, Routes.verificationView);
    });
  } else if (state is ResetPasswordRequestSuccess) {
    showCustomDialog(context, message: AppStrings.resetEmailSendMessage);
  } else if (state is PhoneNumberNeeded) {
    dismissDialog(context);
    TextEditingController _phoneController = TextEditingController();
    GlobalKey<FormState> _key = GlobalKey();
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _key,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFrom(
                          validator: (phone) {
                            return mobileNumberValidator(phone, context);
                          },
                          controller: _phoneController,
                          icon: Icons.phone,
                          label: AppStrings.mobileNumber.tr(context)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FullElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: AppStrings.signIn.tr(context))
                  ],
                ),
              ),
            ),
          );
        });
    BlocProvider.of<AuthenticationBloc>(context)
        .add(MobileNumberEntered(mobileNumber: _phoneController.text));
  }
}
