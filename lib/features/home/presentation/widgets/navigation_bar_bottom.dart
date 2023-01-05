import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

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
    return MaterialButton(
      minWidth: AppSize.s80.w,
      onPressed: () {
        onPress();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
          ),
          Text(
            title,
            style: getAlmaraiRegularStyle(
              fontSize: AppSize.s12.sp,
              color: ColorManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
