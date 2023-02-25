import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });
  final Function onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      title: Row(
        children: [
          Icon(
            icon,
            size: AppSize.s25.sp,
          ),
          SizedBox(width: AppSize.s8.w),
          Text(
            title,
            style: getAlmaraiRegularStyle(
              fontSize: AppSize.s18.sp,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: AppSize.s20.sp,
      ),
    );
  }
}