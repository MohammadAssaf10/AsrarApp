import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/news_entities.dart';
import '../../widgets/general/cached_network_image_widget.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(this.news, {super.key});
  final NewsEntities news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.theNews.tr(context),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: AppSize.s15.h,
          horizontal: AppSize.s8.w,
        ),
        children: [
          CachedNetworkImageWidget(
            image: news.newsImageUrl,
            height: AppSize.s220.h,
            width: double.infinity,
            shapeBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(AppSize.s10.r),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s10.h,
            ),
            child: Text(
              news.newsTitle,
              textAlign: TextAlign.center,
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.primary,
              ),
            ),
          ),
          Text(
            news.newsContent,
            textAlign: TextAlign.center,
            style: getAlmaraiRegularStyle(
              fontSize: AppSize.s18.sp,
              color: ColorManager.lightBlack,
            ),
          ),
        ],
      ),
    );
  }
}
