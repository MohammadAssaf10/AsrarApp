import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class NavigationBarBottom extends StatelessWidget {
  const NavigationBarBottom({
    Key? key,
    required this.title,
    required this.onPress,
    required this.icon,
  }) : super(key: key);
  final String title;
  final Function onPress;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Center(
        child: Container(
          height: double.infinity,
          width: AppSize.s80.w,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s12.sp,
                  color: ColorManager.darkGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
