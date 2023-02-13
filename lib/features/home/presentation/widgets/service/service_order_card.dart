
import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/service_order.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../general/cancel_button.dart';

class ServiceOrderCard extends StatelessWidget {
  const ServiceOrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final ServiceOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s80.h,
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.s8.w,
        vertical: AppSize.s5.h,
      ),
      decoration: ShapeDecoration(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSize.s18.r),
        ),
        color: ColorManager.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Card(
              color: ColorManager.darkWhite,
              shape: CircleBorder(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.orderNNumber.tr(context),
                    textAlign: TextAlign.center,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s16.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(height: AppSize.s2.h),
                  Text(
                    order.id.toString(),
                    textAlign: TextAlign.center,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s16.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.service.tr(context)}: ${order.service.serviceName}",
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s18.sp,
                    color: ColorManager.primary,
                  ),
                ),
                SizedBox(height: AppSize.s10.h),
                Text(
                  "${AppStrings.status.tr(context)}: ${order.status.tr(context)}",
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s18.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),
          (order.status == OrderStatus.pending.name)
              ? CancelButton(onTap: () {
                  showConfirmDialog(context, executeWhenConfirm: () {
                    BlocProvider.of<ServiceOrderBloc>(context).add(
                      CancelOrder(serviceOrder: order),
                    );
                  });
                })
              : SizedBox(width: AppSize.s50.w),
        ],
      ),
    );
  }
}