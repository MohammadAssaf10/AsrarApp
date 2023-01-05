import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../config/app_localizations.dart';
import '../../../data/models/requests.dart';
import '../../bloc/authentication_bloc.dart';
import '../../common/functions.dart';
import '../../common/widgets.dart';
import 'register_bloc.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _mobileNumberTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterBloc(),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(),
          ),
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            manageDialog(context, state);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppSize.s20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.s100.h),
                    Text(
                      AppStrings.signUp.tr(context),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppSize.s60.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocSelector<RegisterBloc, RegisterState, String?>(
                          selector: (state) => state.nameErrorMessage?.tr(context),
                          builder: (context, errorMessage) {
                            return InputField(
                              prefixIcon: Icons.person,
                              controller: _nameTextEditingController,
                              label: AppStrings.name.tr(context),
                              errorText: errorMessage,
                              onChanged: (name) {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(NameChanged(name));
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppSize.s20.h),
                        BlocSelector<RegisterBloc, RegisterState, String?>(
                          selector: (state) => state.emailErrorMessage?.tr(context),
                          builder: (context, emailErrorMessage) {
                            return InputField(
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextEditingController,
                              label: AppStrings.email.tr(context),
                              errorText: emailErrorMessage,
                              onChanged: (email) {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(EmailChanged(email));
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppSize.s20.h),
                        BlocSelector<RegisterBloc, RegisterState, String?>(
                          selector: (state) => state.mobileNumberErrorMessage?.tr(context),
                          builder: (context, mobileNumberErrorMessage) {
                            return InputField(
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              controller: _mobileNumberTextEditingController,
                              label: AppStrings.mobileNumber.tr(context),
                              errorText: mobileNumberErrorMessage,
                              onChanged: (mobileNumber) {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(MobileNumberChanged(mobileNumber));
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppSize.s20.h),
                        BlocSelector<RegisterBloc, RegisterState, String?>(
                          selector: (state) => state.passwordErrorMessage?.tr(context),
                          builder: (context, passwordErrorMessage) {
                            return InputField(
                              prefixIcon: Icons.password,
                              controller: _passwordTextEditingController,
                              label: AppStrings.password.tr(context),
                              errorText: passwordErrorMessage,
                              onChanged: (password) {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(PasswordChanged(password));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s50.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocSelector<RegisterBloc, RegisterState, Status>(
                          selector: (state) => state.status,
                          builder: (context, status) {
                            return FullOutlinedButton(
                                onPressed: (status == Status.accepted
                                    ? () {
                                  BlocProvider.of<AuthenticationBloc>(
                                      context)
                                      .add(RegisterButtonPressed(RegisterRequest(
                                      _nameTextEditingController.text,
                                      _emailTextEditingController
                                          .text,
                                      _mobileNumberTextEditingController
                                          .text,
                                      _passwordTextEditingController
                                          .text)));
                                }
                                    : null),
                                text: AppStrings.signUp.tr(context));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(AppStrings.alreadyHaveAccount.tr(context)),
                            TextButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, Routes.loginRoute),
                                child: Text(AppStrings.signIn.tr(context))),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}