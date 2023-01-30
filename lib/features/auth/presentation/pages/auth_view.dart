import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/app/extensions.dart';
import '../../data/models/requests.dart';
import '../bloc/authentication_bloc.dart';
import '../common/functions.dart';
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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        manageDialog(context, state);
      },
      child: Scaffold(
        appBar: AppBar(),
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
                  Center(
                    child: TextButton(
                      child: Text(
                        AppStrings.continueAsGuest.tr(context),
                        style: TextStyle(color: ColorManager.grey),
                      ),
                      onPressed: () {
                        // TODO: vavigate to main view
                        Navigator.pushReplacementNamed(context, Routes.splash);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
                    // TODO: navigate to reset password
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s100.h,
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

class NewAccountForm extends StatefulWidget {
  NewAccountForm({super.key});

  @override
  State<NewAccountForm> createState() => _NewAccountFormState();
}

class _NewAccountFormState extends State<NewAccountForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();

  bool validateEmail = false;

  bool validatePassword = false;

  bool validateUserName = false;

  bool validatePhoneNumber = false;

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
                  controller: _nameTextEditingController,
                  icon: Icons.person_outline,
                  label: AppStrings.userName.tr(context),
                  onTap: () {
                    setState(() {
                      validateUserName = true;
                    });
                  },
                  validator: (val) {
                    if (validateUserName) {
                      if (val.nullOrEmpty() || val!.length < 3)
                        return AppStrings.nameTooShort.tr(context);
                    }
                    return null;
                  },
                ),
                TextFrom(
                  controller: _phoneNumberTextEditingController,
                  icon: Icons.phone,
                  label: AppStrings.mobileNumber.tr(context),
                  onTap: () {
                    setState(() {
                      validatePhoneNumber = true;
                    });
                  },
                  validator: (val) {
                    if (validatePhoneNumber) {
                      if (val.nullOrEmpty() || val!.length < 5)
                        return AppStrings.mobileNumberShouldAtLeast5Character
                            .tr(context);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  controller: _passwordTextEditingController,
                  icon: Icons.lock_outline,
                  label: AppStrings.password.tr(context),
                  onTap: () {
                    setState(() {
                      validatePassword = true;
                    });
                  },
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
              setState(() {
                validateEmail = true;
                validatePassword = true;
                validateUserName = true;
              });
              if (_key.currentState!.validate()) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(RegisterButtonPressed(
                  RegisterRequest(
                      name: _nameTextEditingController.text,
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text,
                      phoneNumber: _phoneNumberTextEditingController.text),
                ));
              }
            },
            text: AppStrings.registerNewAccount.tr(context),
          )
        ],
      ),
    );
  }
}
