import 'package:asrar_app/config/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../blocs/company_bloc/company_bloc.dart';
import '../blocs/services_bloc/bloc/services_bloc.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              height: AppSize.s220.h,
              child: GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: state.company.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: AppSize.s120.r,
                    mainAxisExtent: AppSize.s80.r,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<ServicesBloc>(context).add(
                          GetServices(
                            companyName: state.company[index].name,
                          ),
                        );
                        Navigator.pushNamed(
                          context,
                          Routes.serviceRoute,
                          arguments: state.company[index],
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: AppSize.s10.w,
                          vertical: AppSize.s5.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.grey,
                              blurRadius: 2.0,
                              offset: Offset(0, 6),
                            ),
                          ],
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
                            color: ColorManager.error,
                          ),
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
