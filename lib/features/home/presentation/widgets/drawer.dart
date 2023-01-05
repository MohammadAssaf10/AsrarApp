import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/assets_manager.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:asrar_app/config/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppSize.s240.w,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(),
            DrawerList(),
          ],
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.darkPrimary,
            ColorManager.primary,
            ColorManager.darkPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "${AppStrings.asrarForElectronicServices.tr(context).substring(0, 5)}\n${AppStrings.asrarForElectronicServices.tr(context).substring(6, AppStrings.asrarForElectronicServices.tr(context).length)}",
          textAlign: TextAlign.center,
          style: getAlmaraiBoldStyle(
            fontSize: AppSize.s25.sp,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppSize.s15.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MenuItem(
              title: AppStrings.info.tr(context),
              icon: IconAssets.info,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.whatsApp.tr(context),
              icon: IconAssets.whatsApp,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.googleTranslate.tr(context),
              icon: IconAssets.googleTranslate,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.subscribe.tr(context),
              icon: IconAssets.subscribe,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.termsOfUse.tr(context),
              icon: IconAssets.termsOfUse,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.signOut.tr(context),
              icon: IconAssets.signOut,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                icon,
                filterQuality: FilterQuality.high,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s18.sp,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
