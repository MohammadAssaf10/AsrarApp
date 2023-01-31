import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/app/extensions.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../data/models/requests.dart';
import '../../bloc/authentication_bloc.dart';
import 'widgets.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  bool validateEmail = false;
  bool validatePassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
      child: Column(
        children: [
          SizedBox(
            height: AppSize.s40.h,
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFrom(
                  controller: _emailTextEditingController,
                  icon: Icons.email_outlined,
                  label: AppStrings.email.tr(context),
                  onTap: () {
                    setState(() {
                      validateEmail = true;
                    });
                  },
                  validator: (v) {
                    if (validateEmail) {
                      if (v.nullOrEmpty())
                        return AppStrings.pleaseEnterEmail.tr(context);

                      if (!isEmailFormatCorrect(v!))
                        return AppStrings.emailFormatNotCorrect.tr(context);
                    }

                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  onTap: () {
                    setState(() {
                      validatePassword = true;
                    });
                  },
                  controller: _passwordTextEditingController,
                  icon: Icons.lock_outline,
                  label: AppStrings.password.tr(context),
                  validator: (v) {
                    if (validatePassword) {
                      if (v.nullOrEmpty() || v!.length < 6)
                        return AppStrings.passwordShouldAtLeast6Character
                            .tr(context);
                    }
                    return null;
                  },
                ),
                TextButton(
                  child: Text(
                    AppStrings.forgetYourPassword.tr(context),
                    style: TextStyle(color: ColorManager.grey),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.passwordReset);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s50.h,
          ),
          FullElevatedButton(
            onPressed: () {
              setState(() {
                validateEmail = true;
                validatePassword = true;
              });
              if (_key.currentState!.validate()) {
                BlocProvider.of<AuthenticationBloc>(context).add(
                    LoginButtonPressed(LoginRequest(
                        _emailTextEditingController.text,
                        _passwordTextEditingController.text)));
              }
            },
            text: AppStrings.signIn.tr(context),
          )
        ],
      ),
    );
  }
}
