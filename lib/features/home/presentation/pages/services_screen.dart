import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../widgets/services_view.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key, required this.comapnyName});
  final String comapnyName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(comapnyName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSize.s10.h),
            Container(
              alignment: Alignment.center,
              height: AppSize.s40.h,
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s10.w,
                vertical: AppSize.s5.h,
              ),
              margin: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s20.r),
                border: Border.all(color: ColorManager.primary),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[" "a-zآ-يA-Z]')),
                      ],
                      decoration: InputDecoration(
                        hintText: AppStrings.searchForYourServices.tr(context),
                        hintStyle: getAlmaraiBoldStyle(
                            fontSize: AppSize.s18.sp,
                            color: ColorManager.darkPrimary),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      IconAssets.search,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            ServicesView(),
          ],
        ),
      ),
    );
  }
}
