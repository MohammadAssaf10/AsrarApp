import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/service_entities.dart';

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
          vertical: AppSize.s5.h,
          horizontal: AppSize.s10.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSize.s8.w),
        height: AppSize.s70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s5.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.primary,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: AppSize.s34.r,
                      backgroundColor: ColorManager.darkWhite,
                      child: Text(
                        AppStrings.asrarServices.tr(context),
                        textAlign: TextAlign.center,
                        style: getAlmaraiBoldStyle(
                          fontSize: AppSize.s16.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    service.serviceName,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s18.sp,
                      color: ColorManager.darkPrimary,
                    ),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
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
