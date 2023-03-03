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
import '../../../../../core/app/di.dart';
import '../../../../shop/presentation/bloc/product_bloc/product_bloc.dart';
import '../../../domain/repository/notification_repository.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../blocs/job_bloc/job_bloc.dart';
import '../../blocs/news_bloc/news_bloc.dart';
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
            onPressed: () async {
              final NotificationRepository n =
              instance<NotificationRepository>();
              (await n.sendNotificationToGroupOfUser([
                /*My phone */
                "dtzf4JTlQ_SDjxWlblwQwM:APA91bHBpS8FTqpTOuc5tXtXumQuhhUO08zwD7ljH9eLLANorr6DzE_-td7PuK87hAsVxIEPqF2OVxDCq4eVEonJ0VX2Yq4zApaWMz-SGj-h8KHPdsO4x-8RETpc-7oV7IK4b8XMdWzO",
                /*Mohsen */
                "dQXW706MS4SpEp2Lah73hY:APA91bEwpKzw4qsyj_p_qOf5M6i6hZYK6EsuZMq2hqhWLRj-IKZ_TTOGShgKawQTTAQC2-PnnU9g0jYx2DMZR11yAyChyIeejFovRlEdtcVWnR45lJHah3QJRBxnHCKHOkqtvqGpBi2D",
                /*Other phone */
                "ch383Jt-TkKJOsDr71oC14:APA91bFmqWXl5sXQCYg45HncZ96Gnu2ETcUHb4xPzfkiAYRpFITA3HGB680dpsvCR53YpTiHX8yseuISOr3HP2lFhUdeCnk9uGvdLv6gXx7VupqXxRc_isoo-oQAUlM-JCxpcisYhefh",
              ], "Asrar", "Asrar For Electronic Services"))
                  .fold((l) {
                print("======>${l.message}");
              }, (r) {
                print("*Notification Sent Successfully*");
              });
              // (await n.sendNotificationToAllUser(
              //         "Asrar", "Asrar For Electronic Services"))
              //     .fold((l) {
              //   print("======>${l.message}");
              // }, (r) {
              //   print("*Notification Sent Successfully*");
              // });
            },
            icon: SvgPicture.asset(IconAssets.notification),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset(IconAssets.share),
          // ),
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
            width: MediaQuery
                .of(context)
                .size
                .width,
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
