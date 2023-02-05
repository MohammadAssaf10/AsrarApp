import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.courses.tr(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CourseBloc, CourseState>(
              builder: (context, state) {
                if (state is CourseLoadingState) {
                  return LoadingView(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                  );
                } else if (state is CourseErrorState) {
                  return ErrorView(
                    errorMessage: state.errorMessage.tr(context),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                  );
                } else if (state is CourseLoadedState) {
                  if (state.courseList.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.courseList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.courseDetailsRoute,
                              arguments: state.courseList[index],
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: AppSize.s8.h,
                              horizontal: AppSize.s10.w,
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: AppSize.s8.w),
                            height: AppSize.s75.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius:
                                  BorderRadius.circular(AppSize.s20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    margin: EdgeInsets.symmetric(
                                      vertical: AppSize.s2.h,
                                    ),
                                    elevation: AppSize.s4,
                                    shape: CircleBorder(
                                      side: BorderSide(
                                        color: ColorManager.backgroundColor,
                                        width: AppSize.s1_5.w,
                                      ),
                                    ),
                                    child: Image.asset(ImageAssets.asrarCourse),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: AppSize.s8.w,
                                        ),
                                        child: Text(
                                          state.courseList[index].courseTitile,
                                          style: getAlmaraiRegularStyle(
                                            fontSize: AppSize.s18.sp,
                                            color: ColorManager.darkPrimary,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: AppSize.s8.w,
                                          vertical: AppSize.s4.h,
                                        ),
                                        child: Text(
                                          state.courseList[index].coursePrice
                                                  .startsWith("0")
                                              ? AppStrings.free.tr(context)
                                              : "${state.courseList[index].coursePrice} ر.س",
                                          style: getAlmaraiRegularStyle(
                                            fontSize: AppSize.s16.sp,
                                            color: ColorManager.darkPrimary,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: AppSize.s5.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.courseList[index].timestamp
                                                  .toDate()
                                                  .toString()
                                                  .substring(0, 10),
                                              style: getAlmaraiRegularStyle(
                                                fontSize: AppSize.s14.sp,
                                                color: ColorManager.grey,
                                              ),
                                            ),
                                            Text(
                                              AppStrings.showDetails
                                                  .tr(context),
                                              style: getAlmaraiRegularStyle(
                                                fontSize: AppSize.s14.sp,
                                                color: ColorManager.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
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
