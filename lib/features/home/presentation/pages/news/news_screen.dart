import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/news_bloc/news_bloc.dart';
import '../../widgets/general/cached_network_image_widget.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

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
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return LoadingView(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is NewsErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is NewsLoadedState) {
            if (state.newsList.isNotEmpty) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.newsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.newsDetailsRoute,
                          arguments: state.newsList[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.s8.h,
                        horizontal: AppSize.s10.w,
                      ),
                      height: AppSize.s90.h,
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
                              // offset: Offset(1, 3),
                              height: AppSize.s90.h,
                              width: double.infinity,
                              verticalMargin: AppSize.s4.h,
                              image: state.newsList[index].newsImageUrl,
                              shapeBorder: const CircleBorder(),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSize.s5.h,
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
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppSize.s10.w,
                                        ),
                                        child: Text(
                                          AppStrings.showDetails
                                              .tr(context),
                                          style: getAlmaraiRegularStyle(
                                            fontSize: AppSize.s14.sp,
                                            color: ColorManager.grey,
                                          ),
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
            } else {
              return EmptyListView(
                emptyListMessage: AppStrings.noNews.tr(context),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
