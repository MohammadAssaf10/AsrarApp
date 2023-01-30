import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../bloc/authentication_bloc.dart';
import '../common/functions.dart';
import '../common/widgets/widgets.dart';

class PasswordResetView extends StatelessWidget {
  PasswordResetView({super.key});

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.resetPassword.tr(context)),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          manageDialog(context, state);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 8.w),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: AppSize.s250.h),
                Form(
                    key: _key,
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFrom(
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        validator: (v) => emailValidator(v, context),
                        label: AppStrings.email.tr(context))),
                SizedBox(height: AppSize.s25.h),
                FullElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            SendVerificationCodeButtonPressed(
                                _emailController.text));
                      }
                    },
                    text: AppStrings.resetPassword.tr(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
