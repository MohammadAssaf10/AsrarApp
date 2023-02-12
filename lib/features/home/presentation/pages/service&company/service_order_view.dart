import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/service_order.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../../widgets/general/empty_list_view.dart';

class ServiceOrderView extends StatelessWidget {
  const ServiceOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceOrderBloc, ServiceOrderState>(
      listener: (context, state) {
        if (state.processStatus == Status.loading) {
          showCustomDialog(context);
        } else if (state.processStatus == Status.failed) {
          showCustomDialog(context, message: state.message);
        } else if (state.serviceOrderListStatus == Status.loading) {
          showCustomDialog(context);
        } else if (state.serviceOrderListStatus == Status.failed) {
          showCustomDialog(context, message: state.message);
        } else {
          dismissDialog(context);
        }
      },
      builder: (context, state) {
        if (state.serviceOrderList.isEmpty) {
          return EmptyListView(
            emptyListMessage: AppStrings.noOrders.tr(context),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        }
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.serviceOrderList.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderCard(
              order: state.serviceOrderList[index],
            );
          },
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
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
                SizedBox(height: AppSize.s4.h),
              ],
            ),
          ),
          (order.status == OrderStatus.pending.name)
              ? CancelButton(order: order)
              : SizedBox(width: AppSize.s50.w),
        ],
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    required this.order,
  }) : super(key: key);

  final ServiceOrder order;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          showConfirmDialog(context, executeWhenConfirm: () {
            BlocProvider.of<ServiceOrderBloc>(context).add(
              CancelOrder(serviceOrder: order),
            );
          });
        },
        icon: Icon(
          Icons.delete,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
