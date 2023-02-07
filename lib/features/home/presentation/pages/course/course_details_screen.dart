import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/course_entities.dart';
import '../../widgets/general/cached_network_image_widget.dart';

class CourseDetailsScereen extends StatelessWidget {
  const CourseDetailsScereen(this.course);
  final CourseEntities course;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseTitile),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: AppSize.s15.h,
          horizontal: AppSize.s8.w,
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            CachedNetworkImageWidget(
              image: course.courseImageUrl,
              height: AppSize.s220.h,
              width: double.infinity,
              shapeBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.transparent),
                borderRadius: BorderRadius.circular(AppSize.s10.r),
              ),
              offset: Offset(0, 0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s10.h,
              ),
              child: Text(
                course.courseContent,
                textAlign: TextAlign.center,
                style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s18.sp,
                  color: ColorManager.lightBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
