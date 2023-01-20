import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/service_entities.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
    required this.service,
  });
  final ServiceEntities service;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.requiredDocumentsRoute,
          arguments: service,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: AppSize.s8.h,
          horizontal: AppSize.s10.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSize.s8.w),
        height: AppSize.s55.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              service.serviceName,
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.darkPrimary,
              ),
            ),
            Text(
              "${service.servicePrice} ر.س",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.darkPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
