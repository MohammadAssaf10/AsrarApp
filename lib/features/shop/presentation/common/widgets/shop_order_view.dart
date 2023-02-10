import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../home/presentation/widgets/general/empty_list_view.dart';
import '../../../../home/presentation/widgets/general/error_view.dart';
import '../../../../home/presentation/widgets/general/loading_view.dart';
import '../../bloc/shop_order_bloc/shop_order_bloc.dart';

class ShopOrderView extends StatelessWidget {
  const ShopOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopOrderBloc, ShopOrderState>(
      listener: (context, state) {
        final authState = BlocProvider.of<AuthenticationBloc>(context).state;
        if (state is CancelShopOrderLoadingState) {
          showCustomDialog(context);
        } else if (state is CancelShopOrderErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
          BlocProvider.of<ShopOrderBloc>(context).add(
            GetShopOrderEvent(
              userEmail: authState.user!.email,
            ),
          );
        } else if (state is ShopOrderCancelledSuccessfullyState) {
          showCustomDialog(context,
              message: AppStrings.orderCancelledSuccessfully.tr(context));
          BlocProvider.of<ShopOrderBloc>(context).add(
            GetShopOrderEvent(
              userEmail: authState.user!.email,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ShopOrderLoadingState)
          return LoadingView(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        if (state is ShopOrderErrorState)
          return ErrorView(
            errorMessage: state.errorMessage.tr(context),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        if (state is ShopOrderLoadedState) if (state.shopOrderList.isNotEmpty) {
          return ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.shopOrderList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Container(
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
                                AppStrings.orderNumber.tr(context),
                                textAlign: TextAlign.center,
                                style: getAlmaraiBoldStyle(
                                  fontSize: AppSize.s18.sp,
                                  color: ColorManager.primary,
                                ),
                              ),
                              SizedBox(height: AppSize.s2.h),
                              Text(
                                state.shopOrderList[index].shopOrderId
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: getAlmaraiBoldStyle(
                                  fontSize: AppSize.s18.sp,
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
                              "${AppStrings.orderStatus.tr(context)}: ${state.shopOrderList[index].orderStatus.tr(context)}",
                              style: getAlmaraiRegularStyle(
                                fontSize: AppSize.s18.sp,
                                color: ColorManager.primary,
                              ),
                            ),
                            SizedBox(height: AppSize.s4.h),
                            Text(
                              "${AppStrings.orderSPrice.tr(context)}: ${state.shopOrderList[index].totalPrice} ر.س",
                              style: getAlmaraiRegularStyle(
                                fontSize: AppSize.s18.sp,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.shopOrderList[index].orderStatus ==
                                OrderStatus.pending.name
                            ? false
                            : true,
                        child: SizedBox(width: AppSize.s50.w),
                      ),
                      Visibility(
                        visible: state.shopOrderList[index].orderStatus ==
                                OrderStatus.pending.name
                            ? true
                            : false,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<ShopOrderBloc>(context).add(
                                CancelShopOrderEvent(
                                    shopOrder: state.shopOrderList[index]),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: ColorManager.primary,
                            ),
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
            emptyListMessage: AppStrings.noOrders.tr(context),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        }
        return SizedBox();
      },
    );
  }
}
