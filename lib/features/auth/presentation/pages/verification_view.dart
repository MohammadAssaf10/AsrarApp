import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../bloc/authentication_bloc.dart';
import '../common/widgets/widgets.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  late int code;
  late AuthenticationBloc authenticationBloc;
  final TextEditingController _codeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    code = Random().nextInt(8999) + 1000;

    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    code = 0000;
    print(code);

    // authenticationBloc.add(SendVerificationCode(
    //     authenticationBloc.state.user!.phoneNumber, code.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.verificationCodeSentTo.tr(context)),
              SizedBox(
                height: AppSize.s10.h,
              ),
              Text(authenticationBloc.state.user!.phoneNumber),
              SizedBox(
                height: AppSize.s10.h,
              ),
              TextFrom(
                  controller: _codeTextEditingController,
                  icon: Icons.comment_rounded,
                  label: AppStrings.verificationCode.tr(context)),
              SizedBox(
                height: AppSize.s10.h,
              ),
              FullElevatedButton(
                  onPressed: () {
                    if (_codeTextEditingController.text == code.toString()) {
                      authenticationBloc.add(VerificationCodeSubmitted());
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Text('الكود الذي ادخلته خاطئ'),
                              ),
                            );
                          });
                    }
                  },
                  text: AppStrings.signIn.tr(context))
            ],
          ),
        ),
      ),
    );
  }
}
