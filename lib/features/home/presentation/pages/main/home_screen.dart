import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/core/app/extensions.dart';
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
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../shop/presentation/bloc/product_bloc/product_bloc.dart';
import '../../../domain/entities/notification.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../blocs/job_bloc/job_bloc.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../blocs/notification_bloc/notification_bloc.dart';
import '../../widgets/ad/ad_image_view.dart';
import '../../widgets/company/companies_view.dart';
import '../../widgets/general/drawer.dart';
import '../../widgets/general/home_button_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
          AppStrings.asrarForElectronicServices.tr(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final authState =
                  BlocProvider.of<AuthenticationBloc>(context).state;
              if (authState.user != null) {
                // BlocProvider.of<NotificationBloc>(context)
                //     .add(GetUserNotifications(userID: authState.user!.id));
                BlocProvider.of<NotificationBloc>(context)
                    .add(GetUserNotifications(userID: "123456"));
              }
              const NotificationInfo notificationInfo = NotificationInfo(
                  title: "Asrar",
                  message: "Hello World!",
                  token:
                      // iPhone 14 Pro Max
                      "fwsTNeSijU89lKwBG4ajni:APA91bEdp68L2cg6LFwAlMYaxxEYEfV0HxO6Lm01HGWYwPKiRHBGzXoV7Bz90SFsl833oitynF5P1q6R07E3FBxo2QQC5EOb8yztDHW7bcp9nE-bVgBNsFFrVEXtkZycxMFhgNYSUMX5",
                  // iPhone 8 plus
                  // "c5vv_uoYX0A0rVJVaZMO7s:APA91bHHjLWYULhKPvhqBa231ro6tg7Jk9y1LYRMNWn9HDiXeEu0SBxvjvWKTAcJYFeu0YiFrFrS_WjaCg_BIO7s9Gh9SosFNX6uYCnakck3RC2lNqmAxTMtdMu76VnWhsvUkYKJkyh5",
                  // Honor 8X
                  // "dBj0wY-MaLk-Hyx74RcbnI:APA91bFJgBmbydZyP5na4L8_tZ8d6R7r8DSzcsnpVe6cY72ZZmdKEVnv0zY3X0CpTUmXFd9hI58WUKc8mIp7wpA-VDNs5lHRhOhlsJUeXp9zR4y_KTKMS0Shhw74ruuE88HUR1DxKzaI",
                  userID: "123456");
              // BlocProvider.of<NotificationBloc>(context).add(
              //     const SendNotificationToAllUser(
              //         message: "Hello World", title: "Asrar"));
            },
            icon: SvgPicture.asset(IconAssets.notification),
          ),
        ],
      ),
      body: Column(
        children: [
          const AdImageView(),
          OptionsWidget(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionButton(
                  onTap: () {
                    BlocProvider.of<JobBloc>(context).add(GetJobsListEvent());
                    Navigator.pushNamed(context, Routes.jobRoute);
                  },
                  title: AppStrings.jobs.tr(context),
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
                    BlocProvider.of<NewsBloc>(context).add(GetNewsListEvent());
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
                    BlocProvider.of<CourseBloc>(context)
                        .add(GetCoursesListEvent());
                    Navigator.pushNamed(context, Routes.courseRoute);
                  },
                  title: AppStrings.courses.tr(context),
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
                Navigator.pushNamed(context, Routes.shopRoute);
                BlocProvider.of<ProductBloc>(context)
                    .add(GetProductsListEvent());
              },
              child: Text(
                AppStrings.myShop.tr(context),
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
            margin: EdgeInsets.symmetric(
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
          const CompaniesView(),
        ],
      ),
    );
  }
}
