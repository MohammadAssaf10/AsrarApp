import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/values_manager.dart';
import 'cached_network_image_widget.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({
    Key? key,
    required this.userImage,
    required this.onPress,
    required this.imagePicked,
  }) : super(key: key);
  final String userImage;
  final String? imagePicked;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          if (userImage.isEmpty && imagePicked == null)
            Card(
              shape: CircleBorder(),
              margin: EdgeInsets.symmetric(vertical: AppSize.s8.h),
              child: Icon(
                Icons.person,
                size: AppSize.s150.sp,
                color: ColorManager.grey,
              ),
            ),
          if (userImage.isNotEmpty && imagePicked == null)
            CachedNetworkImageWidget(
              image: userImage,
              shapeBorder: CircleBorder(),
              height: AppSize.s150.h,
              width: AppSize.s150.w,
              verticalMargin: AppSize.s8.h,
              blurRadius: 10,
              offset: Offset(2, 2),
              boxFit: BoxFit.cover,
            ),
          if (imagePicked != null)
            Container(
              height: AppSize.s150.h,
              width: AppSize.s150.w,
              margin: EdgeInsets.symmetric(vertical: AppSize.s8.h),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                shadows: [
                  BoxShadow(
                    color: ColorManager.grey,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(2, 2),
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    File(imagePicked!),
                  ),
                ),
              ),
            ),
          Positioned(
            right: 0,
            bottom: 8,
            child: ActionChip(
              onPressed: () {
                onPress();
              },
              label: Icon(
                Icons.camera_alt_outlined,
                size: AppSize.s32.sp,
              ),
              backgroundColor: ColorManager.primary,
              side: BorderSide.none,
              shape: CircleBorder(),
              pressElevation: 3,
            ),
          ),
        ],
      ),
    );
  }
}
