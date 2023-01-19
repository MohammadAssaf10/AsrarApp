import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';

class RequiredDocumentsScreen extends StatelessWidget {
  const RequiredDocumentsScreen({
    super.key,
    required this.serviceName,
    required this.requirdDocumentList,
  });
  final String serviceName;
  final List requirdDocumentList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s40.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s10.h,
                horizontal: AppSize.s30.w,
              ),
              child: Text(
                AppStrings.requiredDocuments.tr(context),
                style: getAlmaraiBoldStyle(
                  fontSize: AppSize.s22.sp,
                  color: ColorManager.darkPrimary,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
              height: AppSize.s540.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: requirdDocumentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconAssets.dot),
                        SizedBox(width: AppSize.s3.w),
                        Text(
                          requirdDocumentList[index],
                          style: getAlmaraiRegularStyle(
                            fontSize: AppSize.s20.sp,
                            color: ColorManager.darkPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
