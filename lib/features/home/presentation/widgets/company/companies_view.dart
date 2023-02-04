import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/features/home/presentation/widgets/general/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/company_bloc/company_bloc.dart';
import '../../blocs/services_bloc/bloc/services_bloc.dart';
import '../general/error_view.dart';
import '../general/loading_view.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state is CompanyLoadingState) {
          return LoadingView(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state is CompanyErrorState) {
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state is CompanyLoadedState) {
          if (state.company.isNotEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3.2,
              child: GridView.builder(
                itemCount: state.company.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: AppSize.s120.w,
                  mainAxisExtent: AppSize.s75.h,
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
                    child: CachedNetworkImageWidget(
                      image: state.company[index].image,
                      offset: Offset(0, 6),
                      horizontalMargin: AppSize.s10.w,
                      verticalMargin: AppSize.s5.h,
                      shapeBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.transparent),
                        borderRadius: BorderRadius.circular(AppSize.s10.r),
                      ),
                    ),
                  );
                },
              ),
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
