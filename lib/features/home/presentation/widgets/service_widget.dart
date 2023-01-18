import 'package:asrar_app/config/styles_manager.dart';
import 'package:asrar_app/features/home/presentation/pages/required_documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.requiredDocument,
  });
  final String serviceName;
  final String servicePrice;
  final List requiredDocument;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RequiredDocumentsScreen(
              serviceName: serviceName,
              requirdDocumentList: requiredDocument,
            ),
          ),
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
              serviceName,
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.darkPrimary,
              ),
            ),
            Text(
              "$servicePrice ر.س",
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
