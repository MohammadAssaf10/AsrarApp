import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../bloc/authentication_bloc.dart';
import '../common/functions.dart';
import '../common/widgets/login_form.dart';
import '../common/widgets/new_account_form.dart';
import '../common/widgets/widgets.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

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
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
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
                  const SizedBox(width: double.infinity),
                  if (_login) const LoginForm(),
                  if (!_login) const NewAccountForm(),
                  const Divider(),
                  const Center(
                    child: Text('او'),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(GoogleLoginButtonPressed());
                      },
                      child: SvgPicture.asset(IconAssets.gmail),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: Text(
                        AppStrings.continueAsGuest.tr(context),
                        style: const TextStyle(color: ColorManager.grey),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.homeRoute);
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
