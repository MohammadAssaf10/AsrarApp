import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        errorMessage,
        style: getAlmaraiRegularStyle(
          fontSize: AppSize.s20.sp,
          color: ColorManager.error,
        ),
      ),
    );
  }
}
