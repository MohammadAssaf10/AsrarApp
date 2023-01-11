import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/di.dart';
import '../../domain/use_cases/get_file.dart';
import '../blocs/ad_image_bloc.dart';
import '../widgets/ad_image_view.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdImageBloc(getFileUseCase: instance<GetFileUseCase>())
            ..add(GetAdImage()),
      child: Scaffold(
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
        body: Column(
          children: [
            AdImageView(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppSize.s12.w),
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
            )
          ],
        ),
      ),
    );
  }
}
