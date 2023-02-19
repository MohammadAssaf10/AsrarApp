import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/job_entities.dart';
import '../../widgets/general/cached_network_image_widget.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen(this.job);
  final JobEntities job;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobTitle),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: AppSize.s15.h,
          horizontal: AppSize.s8.w,
        ),
        children: [
          CachedNetworkImageWidget(
            image: job.jobImageUrl,
            height: AppSize.s220.h,
            width: double.infinity,
            shapeBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.transparent,
              ),
              borderRadius: BorderRadius.circular(AppSize.s10.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s10.h,
            ),
            child: Text(
              job.jobDetails,
              textAlign: TextAlign.center,
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
