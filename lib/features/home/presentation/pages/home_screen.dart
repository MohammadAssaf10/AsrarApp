import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../widgets/ad_image_view.dart';
import '../widgets/companies_view.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          AppStrings.asrarForElectronicServices.tr(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(IconAssets.notification),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(IconAssets.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdImageView(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
              width: double.infinity,
              height: AppSize.s40.h,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s18.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    minWidth: AppSize.s80.w,
                    child: Text(
                      "وظائف",
                      style: getAlmaraiRegularStyle(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: AppSize.s80.w,
                    child: Text(
                      "أخبار",
                      style: getAlmaraiRegularStyle(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: AppSize.s80.w,
                    child: Text(
                      "جديدنا",
                      style: getAlmaraiRegularStyle(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: AppSize.s80.w,
                    child: Text(
                      "الدورات",
                      style: getAlmaraiRegularStyle(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
              width: double.infinity,
              height: AppSize.s40.h,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s18.r),
              ),
              child: Center(
                child: Text(
                  "متجرنا",
                  style: getAlmaraiBoldStyle(
                    fontSize: 18.sp,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s8.h,
                horizontal: AppSize.s12.w,
              ),
              child: Text(
                AppStrings.services.tr(context),
                style: getAlmaraiBoldStyle(
                  fontSize: AppSize.s18.sp,
                  color: ColorManager.darkPrimary,
                ),
              ),
            ),
            CompaniesView(),
          ],
        ),
      ),
    );
  }
}
