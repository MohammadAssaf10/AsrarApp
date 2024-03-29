import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/core/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/product_entities.dart';
import '../../domain/entities/shop_order_entities.dart';
import '../bloc/shop_order_bloc/shop_order_bloc.dart';
import '../common/function.dart';
import '../common/widgets/cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(this.cartList, {super.key});

  final List<ProductEntities> cartList;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void dispose() {
    super.dispose();
    for (var element in widget.cartList) {
      element.productCount = 1;
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopOrderBloc, ShopOrderState>(
      listener: (context, state) {
        if (state is ShopOrderLoadingState) {
          showCustomDialog(context);
        } else if (state is ShopOrderErrorState) {
          showCustomDialog(context, message: state.errorMessage.tr(context));
        } else if (state is ShopOrderAddedSuccessfullyState) {
          showCustomDialog(context,
              message: AppStrings.orderAddedSuccessfully.tr(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.cart.tr(context)),
        ),
        body: ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.cartList.length,
          itemBuilder: (_, int index) {
            return CartWidget(
              product: widget.cartList[index],
            );
          },
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(
            vertical: AppSize.s12.h,
            horizontal: AppSize.s12.w,
          ),
          color: ColorManager.transparent,
          height: AppSize.s40.h,
          child: ElevatedButton(
            onPressed: () {
              final state = BlocProvider.of<AuthenticationBloc>(context).state;
              if (state.status == AuthStatus.loggedIn) {
                showOrderDialog(
                  context,
                  AppStrings.whatsAppNumber.tr(context),
                  state.user!.phoneNumber
                      .substring(3, state.user!.phoneNumber.length),
                  widget.cartList,
                  formKey,
                  state.user!,
                  widget.cartList,
                  (String phoneNumber,String chargeId) {
                    if (formKey.currentState!.validate()) {
                      final ShopOrderEntities shopOrder = ShopOrderEntities(
                          shopOrderId: 1,
                          chargeId:chargeId,
                          user: state.user!,
                          phoneNumber: phoneNumber,
                          products: widget.cartList,
                          totalPrice: getTotalProductsPrice(widget.cartList),
                          orderStatus: OrderStatus.pending.name);
                      BlocProvider.of<ShopOrderBloc>(context).add(
                        AddShopOrderEvent(shopOrder: shopOrder),
                      );
                    }
                  },
                );
              }
            },
            child: Text(
              AppStrings.addOrder.tr(context),
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s22.sp,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
