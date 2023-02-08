import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSize.s15.w),
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
      width: double.infinity,
      height: AppSize.s40.h,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(AppSize.s18.r),
      ),
      child: child,
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.height,
    required this.width,
    required this.fontSize,
  });
  final Function onTap;
  final String title;
  final double height;
  final double width;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(
            AppSize.s18.r,
          ),
        ),
        child: MaterialButton(
          height: height,
          onPressed: () {
            onTap();
          },
          child: Text(
            title,
            style: getAlmaraiRegularStyle(
              fontSize: fontSize,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    );
  }
}
