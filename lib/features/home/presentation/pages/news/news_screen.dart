import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../widgets/cached_network_image_widget.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.news.tr(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingState)
                  return LoadingView();
                else if (state is NewsErrorState)
                  return ErrorView(
                    errorMessage: state.errorMessage.tr(context),
                  );
                else if (state is NewsLoadedState) {
                  if (state.newsList.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.newsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.s8.h,
                              horizontal: AppSize.s10.w,
                            ),
                            height: AppSize.s85.h,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CachedNetworkImageWidget(
                                    offset: Offset(1, 3),
                                    horizontalMargin: AppSize.s0.w,
                                    verticalMargin: AppSize.s4.h,
                                    image: state.newsList[index].newsImageUrl,
                                    shapeBorder: CircleBorder(),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      // horizontal: AppSize.s5.w,
                                      vertical: AppSize.s15.h,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Center(
                                          child: Text(
                                            state.newsList[index].newsTitle,
                                            style: getAlmaraiBoldStyle(
                                              fontSize: AppSize.s17.sp,
                                              color: ColorManager.primary,
                                            ),
                                            maxLines: 3,
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.newsList[index].timestamp
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 10),
                                              style: getAlmaraiRegularStyle(
                                                fontSize: AppSize.s14.sp,
                                                color: ColorManager.grey,
                                              ),
                                            ),
                                            Text(
                                              "عرض التفاصيل",
                                              style: getAlmaraiRegularStyle(
                                                fontSize: AppSize.s14.sp,
                                                color: ColorManager.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: AppSize.s240.h),
                      child: Text(
                        AppStrings.noServices.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s20.sp,
                          color: ColorManager.error,
                        ),
                      ),
                    );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
