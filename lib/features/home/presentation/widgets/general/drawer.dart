import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/di.dart';
import '../../../../../core/app/language.dart';
import '../../../../../language_cubit/language_cubit.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
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
          children: const [
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
      decoration: const BoxDecoration(
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
                BlocProvider.of<AboutUsBloc>(context).add(GetAbuotUsEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsScreen(),
                  ),
                );
              },
            ),
            MenuItem(
              title: AppStrings.whatsApp.tr(context),
              icon: IconAssets.whatsApp,
              onTap: () async {
                final Uri url =
                    Uri.parse("whatsapp://send?phone=+966560777194");
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
            ),
            LanguageMenuItem(
              title: AppStrings.googleTranslate.tr(context),
              icon: IconAssets.googleTranslate,
              onTap: () {},
            ),
            MenuItem(
              title: AppStrings.otherServices.tr(context),
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
                BlocProvider.of<TermsOfUseBloc>(context)
                    .add(GetTermsOfUseEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsOfUseScreen(),
                  ),
                );
              },
            ),
            MenuItem(
              title: AppStrings.signOut.tr(context),
              icon: IconAssets.signOut,
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LogOut());
              },
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
    return InkWell(
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
          Divider(
            height: AppSize.s0_5.h,
            thickness: AppSize.s1.h,
          ),
        ],
      ),
    );
  }
}

class LanguageMenuItem extends StatelessWidget {
  const LanguageMenuItem({
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
    String? dropdownValue =
        instance<SharedPreferences>().getString(prefsKeyLang)?.tr(context);
    return InkWell(
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
                  child: DropdownButton<String>(
                    hint: Text(
                      dropdownValue ?? AppStrings.googleTranslate.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s20.sp,
                        color: ColorManager.primary,
                      ),
                    ),
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s20.sp,
                      color: ColorManager.primary,
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: AppStrings.arabic.tr(context),
                        child: Text(
                          AppStrings.arabic.tr(context),
                        ),
                        onTap: () {
                          context.read<LanguageCubit>().setArabic();
                        },
                      ),
                      DropdownMenuItem<String>(
                        value: AppStrings.english.tr(context),
                        child: Text(
                          AppStrings.english.tr(context),
                        ),
                        onTap: () {
                          context.read<LanguageCubit>().setEnglish();
                        },
                      ),
                    ],
                    onChanged: (value) {},
                    iconDisabledColor: ColorManager.primary,
                    iconEnabledColor: ColorManager.primary,
                    underline: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Container(
                        width: AppSize.s85.w,
                        height: AppSize.s1.h,
                        color: ColorManager.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: AppSize.s0_5.h,
            thickness: AppSize.s1.h,
          ),
        ],
      ),
    );
  }
}
