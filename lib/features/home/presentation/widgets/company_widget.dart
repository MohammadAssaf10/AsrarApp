import 'package:asrar_app/config/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/use_cases/get_services.dart';
import '../blocs/company_bloc/company_bloc.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetServicesUseCase getServicesUseCase = GetServicesUseCase();
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state is CompanyLoadingState) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.s60.h),
            child: Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            ),
          );
        } else if (state is CompanyErrorState) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: AppSize.s60.h),
            alignment: Alignment.center,
            child: Text(
              state.errorMessage.tr(context),
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s20.sp,
                color: ColorManager.error,
              ),
            ),
          );
        } else if (state is CompanyLoadedState) {
          if (state.company.isNotEmpty) {
            return Container(
              height: AppSize.s230.h,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.company.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: AppSize.s120.r,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        getServicesUseCase(state.company[index].name);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppSize.s10.w,
                          vertical: AppSize.s5.h,
                        ),
                        height: AppSize.s90.h,
                        width: AppSize.s100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10.r),
                          border: Border.all(
                            color: ColorManager.lightBlue,
                            width: AppSize.s1_5.w,
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: state.company[index].image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppSize.s10.r),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: ColorManager.error),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(vertical: AppSize.s60.h),
              alignment: Alignment.center,
              child: Text(
                AppStrings.noServices.tr(context),
                style: getAlmaraiRegularStyle(
                  fontSize: AppSize.s20.sp,
                  color: ColorManager.error,
                ),
              ),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
