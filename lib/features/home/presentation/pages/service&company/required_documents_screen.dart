import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../domain/entities/service_entities.dart';
import '../../../domain/entities/service_order.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../../widgets/general/home_button_widgets.dart';

class RequiredDocumentsScreen extends StatelessWidget {
  const RequiredDocumentsScreen(
    this.service,
  );
  final ServiceEntities service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceName),
      ),
      body: ListView(
        children: [
          SizedBox(height: AppSize.s40.h),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s10.h,
              horizontal: AppSize.s30.w,
            ),
            child: Text(
              AppStrings.requiredDocuments.tr(context),
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s22.sp,
                color: ColorManager.darkPrimary,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.s30.w,
            ),
            child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: service.requiredDocuments.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(IconAssets.dot),
                      SizedBox(width: AppSize.s3.w),
                      SizedBox(
                        width: AppSize.s260.w,
                        child: Text(
                          service.requiredDocuments[index],
                          style: getAlmaraiRegularStyle(
                            fontSize: AppSize.s20.sp,
                            color: ColorManager.darkPrimary,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: AppSize.s15.h),
          Center(
            child: OptionButton(
              onTap: () {
                print("${MediaQuery.of(context).size.height}");
                // TODO: remove this (but it after the payment screen)
                var user = BlocProvider.of<AuthenticationBloc>(context).state.user!;
                BlocProvider.of<ServiceOrderBloc>(context).add(AddOrder(
                    serviceOrder: ServiceOrder(
                  id: 0,
                  service: service,
                  user: user,
                  status: OrderStatus.pending,
                )));
                // TODO: remove comment
                // Navigator.push(context, MaterialPageRoute(builder: (context) => PayScreen()));
              },
              title: AppStrings.checkout.tr(context),
              height: AppSize.s35.h,
              width: AppSize.s200.w,
              fontSize: AppSize.s18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
