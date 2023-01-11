import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/app/extensions.dart';
import '../../data/models/requests.dart';
import '../bloc/authentication_bloc.dart';
import '../common/widgets.dart';

class Auth extends StatefulWidget {
  Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 8.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                AuthSwitcher(
                  onChange: (v) {
                    setState(() {
                      _login = v;
                    });
                  },
                ),
                SizedBox(width: double.infinity),
                if (_login) LoginForm(),
                if (!_login) NewAccountForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

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
                  validator: (v) {
                    if (v.nullOrEmpty())
                      return AppStrings.pleaseEnterEmail.tr(context);

                    if (!isEmailFormatCorrect(v!))
                      return AppStrings.emailFormatNotCorrect.tr(context);

                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  controller: _passwordTextEditingController,
                  icon: Icons.lock_outline,
                  label: AppStrings.password.tr(context),
                  validator: (v) {
                    if (v.nullOrEmpty() || v!.length < 6)
                      return AppStrings.passwordShouldAtLeast6Character
                          .tr(context);

                    return null;
                  },
                ),
                TextButton(
                  child: Text(
                    AppStrings.forgetYourPassword.tr(context),
                    style: TextStyle(color: ColorManager.grey),
                  ),
                  onPressed: () {
                    // TODO: navigate to reset password
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s100.h,
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return FullElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        LoginButtonPressed(LoginRequest(
                            _emailTextEditingController.text,
                            _passwordTextEditingController.text)));
                  }
                },
                text: AppStrings.signIn.tr(context),
              );
            },
          )
        ],
      ),
    );
  }
}

class NewAccountForm extends StatelessWidget {
  NewAccountForm({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFrom(
                  icon: Icons.email_outlined,
                  label: AppStrings.email.tr(context),
                  validator: (v) {
                    if (v.nullOrEmpty())
                      return AppStrings.pleaseEnterEmail.tr(context);

                    if (!isEmailFormatCorrect(v!))
                      return AppStrings.emailFormatNotCorrect.tr(context);

                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  icon: Icons.person_outline,
                  label: AppStrings.userName.tr(context),
                  validator: (val) {
                    if (val.nullOrEmpty() || val!.length < 3)
                      return AppStrings.nameTooShort.tr(context);

                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  icon: Icons.lock_outline,
                  label: AppStrings.password.tr(context),
                  validator: (v) {
                    if (v.nullOrEmpty() || v!.length < 6)
                      return AppStrings.passwordShouldAtLeast6Character
                          .tr(context);

                    return null;
                  },
                ),
                TextButton(
                  child: Text(
                    AppStrings.forgetYourPassword.tr(context),
                    style: TextStyle(color: ColorManager.grey),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s100.h,
          ),
          FullElevatedButton(
            onPressed: () {
              _key.currentState!.validate();
            },
            text: AppStrings.registerNewAccount.tr(context),
          )
        ],
      ),
    );
  }
}
