import 'package:asrar_app/config/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../home/presentation/widgets/general/home_button_widgets.dart';
import '../../../home/presentation/widgets/general/input_form_field.dart';
import '../../domain/entities/product_entities.dart';

Future<int> getLastId() async {
  int id = 0;
  final data = await FirebaseFirestore.instance
      .collection(FireBaseCollection.shopOrders)
      .get();
  if (data.size > 0) {
    for (var doc in data.docs) {
      if (doc["shopOrderId"] > id) {
        id = doc["shopOrderId"];
      }
    }
  }
  return id;
}

void showOrderDialog(
  BuildContext context,
  String title,
  String number,
  TextEditingController controller,
  List<ProductEntities> cartList,
  Function acceptOnTap,
) {
  dismissDialog(context);
  controller.text = number;
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          "${AppStrings.totalPrice.tr(context)}: ${getTotalProductsPrice(cartList)} ر.س",
          style: getAlmaraiRegularStyle(
            fontSize: AppSize.s20.sp,
            color: ColorManager.primary,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s20.sp,
                    color: ColorManager.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.s10.h),
              InputFormField(
                controller: controller,
                hintText: title,
                height: AppSize.s40.h,
                textInputType: TextInputType.phone,
                regExp: getNumberInputFormat(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionButton(
                  onTap: () {
                    if (controller.text.isNotEmpty) acceptOnTap();
                  },
                  title: AppStrings.checkout.tr(context),
                  height: AppSize.s35.h,
                  width: AppSize.s120.w,
                  fontSize: AppSize.s18.sp,
                ),
                SizedBox(
                  width: AppSize.s5.w,
                ),
                OptionButton(
                  onTap: () {
                    dismissDialog(context);
                  },
                  title: AppStrings.cancel.tr(context),
                  height: AppSize.s35.h,
                  width: AppSize.s120.w,
                  fontSize: AppSize.s20.sp,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

String getTotalProductsPrice(List<ProductEntities> cartList) {
  double totalPrice = 0.0;
  cartList.forEach((product) {
    totalPrice = totalPrice +
        (product.productCount * stringToDouble(product.productPrice));
  });
  totalPrice = dp(totalPrice, 2);
  return totalPrice.toString();
}
