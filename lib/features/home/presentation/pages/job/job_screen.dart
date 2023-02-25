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
import '../../blocs/job_bloc/job_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

class JobScreen extends StatelessWidget {
  const JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.jobs.tr(context),
        ),
      ),
      body: BlocBuilder<JobBloc, JobState>(
        builder: (context, state) {
          if (state is JobLoadingState) {
            return LoadingView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state is JobErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state is JobsLoadedState) {
            if (state.jobsList.isNotEmpty) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.jobsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.jobDetailsRoute,
                        arguments: state.jobsList[index],
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: AppSize.s8.h,
                        horizontal: AppSize.s10.w,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: AppSize.s8.w),
                      height: AppSize.s75.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppSize.s20.r),
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
                              child: Image.asset(ImageAssets.asrarJob),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: AppSize.s5.w,
                                  ),
                                  child: Text(
                                    state.jobsList[index].jobTitle,
                                    style: getAlmaraiRegularStyle(
                                      fontSize: AppSize.s18.sp,
                                      color: ColorManager.darkPrimary,
                                    ),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(height: AppSize.s20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.jobsList[index].timestamp
                                          .toDate()
                                          .toString()
                                          .substring(0, 10),
                                      style: getAlmaraiRegularStyle(
                                        fontSize: AppSize.s14.sp,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.showDetails.tr(context),
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
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return EmptyListView(
                emptyListMessage: AppStrings.noJobs.tr(context),
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
