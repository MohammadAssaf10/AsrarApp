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
import 'login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
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
                padding: EdgeInsets.all(AppSize.s20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: AppSize.s130.h),
                    Text(
                      AppStrings.signIn.tr(context),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: AppSize.s60.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocSelector<LoginBloc, LoginState, String?>(
                            selector: (state) => state.emailErrorMessage?.tr(context),
                            builder: (context, errorText) {
                              return InputField(
                                prefixIcon: Icons.email,
                                controller: _emailTextEditingController,
                                label: AppStrings.email.tr(context),
                                errorText: errorText,
                                onChanged: (email) =>
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(EmailChanged(email)),
                              );
                            }),
                        SizedBox(height: AppSize.s20.h),
                        BlocSelector<LoginBloc, LoginState, String?>(
                            selector: (state) => state.passwordErrorMessage?.tr(context),
                            builder: (context, errorText) {
                              return InputField(
                                prefixIcon: Icons.password,
                                controller: _passwordTextEditingController,
                                label: AppStrings.password.tr(context),
                                errorText: errorText,
                                onChanged: (password) =>
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(PasswordChanged(password)),
                              );
                            }),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.resetPassword);
                          },
                          child: Text(AppStrings.forgetYourPassword.tr(context)),
                        )
                      ],
                    ),
                    SizedBox(height: AppSize.s20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocSelector<LoginBloc, LoginState, Status>(
                          selector: (state) => state.status,
                          builder: (context, status) {
                            return FullOutlinedButton(
                                onPressed: (status == Status.accepted
                                    ? () {
                                  BlocProvider.of<AuthenticationBloc>(
                                      context)
                                      .add(LoginButtonPressed(LoginRequest(
                                      _emailTextEditingController
                                          .text,
                                      _passwordTextEditingController
                                          .text)));
                                }
                                    : null),
                                text: AppStrings.signIn.tr(context));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(AppStrings.notHaveAccountYet.tr(context)),
                            TextButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                    context, Routes.registerRoute),
                                child: Text(AppStrings.signUp.tr(context))),
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