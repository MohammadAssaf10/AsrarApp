import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/assets_manager.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:asrar_app/config/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../pages/main/about_us.dart';
import '../../pages/main/terms_of_use_screen.dart';

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
              title: AppStrings.aboutUs.tr(context),
              icon: IconAssets.info,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsScreen(),
                  ),
                );
              },
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
              onTap: () {
                BlocProvider.of<SubscriptionBloc>(context)
                    .add(GetSubscriptionsEvent());
                Navigator.pushNamed(context, Routes.subscriptionRoute);
              },
            ),
            MenuItem(
              title: AppStrings.termsOfUse.tr(context),
              icon: IconAssets.termsOfUse,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsOfUseScreen(),
                  ),
                );
              },
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s12.h,
                horizontal: AppSize.s5.w,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      icon,
                      height: AppSize.s24.h,
                      width: AppSize.s24.w,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s20.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s0_5.h,
              width: double.infinity,
              child: Material(
                color: ColorManager.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
