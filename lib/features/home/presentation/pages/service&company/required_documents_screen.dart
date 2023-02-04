import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/service_entities.dart';
import '../../widgets/general/home_button_widgets.dart';
import '../pay/pay_screen.dart';

class RequiredDocumentsScreen extends StatelessWidget {
  const RequiredDocumentsScreen(
    this.service,
  );
  final ServiceEntities service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceName),
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s30.w,
              ),
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: service.requiredDocuments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconAssets.dot),
                        SizedBox(width: AppSize.s3.w),
                        SizedBox(
                          width: AppSize.s260.w,
                          child: Text(
                            service.requiredDocuments[index],
                            style: getAlmaraiRegularStyle(
                              fontSize: AppSize.s20.sp,
                              color: ColorManager.darkPrimary,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: AppSize.s15.h),
            Center(
              child: OptionButton(
                onTap: () {
                  print("${MediaQuery.of(context).size.height}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayScreen(),
                    ),
                  );
                },
                title: AppStrings.checkout.tr(context),
                height: AppSize.s35.h,
                width: AppSize.s200.w,
                fontSize: AppSize.s18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
