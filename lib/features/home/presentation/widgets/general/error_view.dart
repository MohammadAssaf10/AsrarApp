import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(
      {super.key,
      required this.errorMessage,
      required this.height,
      required this.width});
  final String errorMessage;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: getAlmaraiRegularStyle(
          fontSize: AppSize.s20.sp,
          color: ColorManager.error,
        ),
      ),
    );
  }
}
