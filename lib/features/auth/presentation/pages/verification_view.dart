import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/authentication_bloc.dart';
import '../common/widgets/widgets.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

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
              Text('تم ارسال رمز التحقق الى الرقم التالي'),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationStateA>(
                builder: (context, state) {
                  if (state is AuthenticationSuccess)
                    return Text(state.user.phoneNumber);
                  return SizedBox();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFrom(icon: Icons.comment_rounded, label: 'رمز التحقق'),
              SizedBox(
                height: 10,
              ),
              FullElevatedButton(onPressed: () {}, text: 'تسجيل الدخول')
            ],
          ),
        ),
      ),
    );
  }
}
