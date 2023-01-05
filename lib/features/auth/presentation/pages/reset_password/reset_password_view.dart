import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../config/app_localizations.dart';
import '../../bloc/authentication_bloc.dart' as auth;
import '../../common/functions.dart';
import '../../common/widgets.dart';
import 'reset_password_bloc.dart';

class ResetPasswordView extends StatelessWidget {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.s20.h),
          child: BlocBuilder<auth.AuthenticationBloc, auth.AuthenticationState>(
            builder: (context, state) {
              manageDialog(context, state);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    AppStrings.resetPassword.tr(context),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          InputField(
                            label: AppStrings.email.tr(context),
                            controller: _emailTextEditingController,
                            errorText: state.emailErrorMessage?.tr(context),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (email) {
                              BlocProvider.of<ResetPasswordBloc>(context)
                                  .add(EmailChanged(email));
                            },
                          ),
                          SizedBox(height: AppSize.s20.h),
                          FullOutlinedButton(
                              onPressed: state.emailStatus == Status.accepted
                                  ? () {
                                      BlocProvider.of<ResetPasswordBloc>(
                                              context)
                                          .add(
                                              SendVerificationCodeButtonPressed());
                                      BlocProvider.of<auth.AuthenticationBloc>(
                                              context)
                                          .add(auth
                                              .SendVerificationCodeButtonPressed(
                                                  _emailTextEditingController
                                                      .text));
                                    }
                                  : null,
                              text: AppStrings.sendVerificationCode.tr(context)),
                        ],
                      );
                    },
                  ),
                  const SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
