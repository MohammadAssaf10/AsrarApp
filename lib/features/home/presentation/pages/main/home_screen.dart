import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../blocs/product_bloc/product_bloc.dart';
import '../../widgets/ad/ad_image_view.dart';
import '../../widgets/company/companies_view.dart';
import '../../widgets/general/drawer.dart';
import '../../widgets/general/home_button_widgets.dart';

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
          children: [
            AdImageView(),
            OptionsWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OptionButton(
                    onTap: () {
                      print("وظائف");
                    },
                    title: "وظائف",
                    height: double.infinity,
                    width: AppSize.s100.w,
                    fontSize: AppSize.s16.sp,
                  ),
                  Container(
                    color: ColorManager.grey,
                    height: double.infinity,
                    width: AppSize.s2.w,
                  ),
                  OptionButton(
                    onTap: () {
                      BlocProvider.of<NewsBloc>(context)
                          .add(GetNewsListEvent());
                      Navigator.pushNamed(context, Routes.newsRoute);
                    },
                    title: AppStrings.news.tr(context),
                    height: double.infinity,
                    width: AppSize.s100.w,
                    fontSize: AppSize.s16.sp,
                  ),
                  Container(
                    color: ColorManager.grey,
                    height: double.infinity,
                    width: AppSize.s2.w,
                  ),
                  OptionButton(
                    onTap: () {
                      print("الدورات");
                    },
                    title: "الدورات",
                    height: double.infinity,
                    width: AppSize.s100.w,
                    fontSize: AppSize.s16.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            OptionsWidget(
              child: MaterialButton(
                onPressed: () {
                  BlocProvider.of<ProductBloc>(context)
                      .add(GetProductsListEvent());
                  Navigator.pushNamed(context, Routes.shopRoute);
                },
                child: Text(
                  AppStrings.shop.tr(context),
                  textAlign: TextAlign.center,
                  style: getAlmaraiBoldStyle(
                    fontSize: 18.sp,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            Container(
              margin:   EdgeInsets.symmetric(
                vertical: AppSize.s5.h,
                horizontal: AppSize.s15.w,
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppStrings.services.tr(context),
                textAlign: TextAlign.start,
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


