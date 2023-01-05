import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../core/app/functions.dart';
import '../bloc/authentication_bloc.dart';

manageDialog(BuildContext context, AuthenticationState state) {
  if (state is AuthenticationInProgress) {
    showCustomDialog(context);
  } else if (state is AuthenticationFailed) {
    showCustomDialog(context,
        jsonPath: JsonAssets.error, message: state.message);
  } else if (state is AuthenticationSuccess) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dismissDialog(context);
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    });
  } else if (state is ResetPasswordRequestSuccess) {
    showCustomDialog(context, message: AppStrings.resetEmailSendMessage);
  }
}
