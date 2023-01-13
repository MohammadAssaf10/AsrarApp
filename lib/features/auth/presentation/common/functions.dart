import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/app_localizations.dart';
import '../../../../core/app/functions.dart';
import '../bloc/authentication_bloc.dart';

ShapeBorder roundedBorder({double radius = 30}) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.r));

manageDialog(BuildContext context, AuthenticationState state) {
  if (state is AuthenticationInProgress) {
    showCustomDialog(context);
  } 
  else if (state is AuthenticationFailed) {
    BlocProvider.of<AuthenticationBloc>(context).add(Reload());
    showCustomDialog(context,
        jsonPath: JsonAssets.error, message: state.message.tr(context));
  } 
  else if (state is AuthenticationSuccess) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
    BlocProvider.of<AuthenticationBloc>(context).add(Reload());
      dismissDialog(context);
      // TODO: navigate to main view
      Navigator.pushReplacementNamed(context, Routes.splash);
    });
  } 
  else if (state is ResetPasswordRequestSuccess) {
    BlocProvider.of<AuthenticationBloc>(context).add(Reload());
    showCustomDialog(context, message: AppStrings.resetEmailSendMessage);
  }
}
