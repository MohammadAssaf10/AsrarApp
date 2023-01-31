import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../blocs/services_bloc/bloc/services_bloc.dart';
import 'service_widget.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<ServicesBloc, ServicesState>(
            builder: (context, state) {
              if (state is LoadingServicesState)
                return Container(
                  margin: EdgeInsets.symmetric(vertical: AppSize.s240.h),
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                );
              else if (state is ErrorServicesState)
                return Container(
                  margin: EdgeInsets.symmetric(vertical: AppSize.s240.h),
                  child: Text(
                    state.errorMessage.tr(context),
                    style: getAlmaraiRegularStyle(
                      fontSize: AppSize.s20.sp,
                      color: ColorManager.error,
                    ),
                  ),
                );
              else if (state is LoadedServicesState) {
                if (state.services.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceWidget(
                        service: state.services[index],
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
    );
  }
}
