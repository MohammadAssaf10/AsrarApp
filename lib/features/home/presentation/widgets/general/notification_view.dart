import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/notification.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key, required this.notificationInfo})
      : super(key: key);
  final NotificationInfo notificationInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.s10.w,
        vertical: AppSize.s10.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s8.w,
        vertical: AppSize.s8.h,
      ),
      decoration: ShapeDecoration(
        color: ColorManager.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10.r),
          borderSide: BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationInfo.title,
            style: getAlmaraiRegularStyle(
              fontSize: AppSize.s22.sp,
              color: ColorManager.primary,
            ),
          ),
          SizedBox(height: AppSize.s5.h),
          Text(
            notificationInfo.message,
            style: getAlmaraiRegularStyle(
              fontSize: AppSize.s20.sp,
              color: ColorManager.primary,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              notificationInfo.timeStamp.toDate().toString().substring(0,10),
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s15.sp,
                color: ColorManager.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
