import 'package:asrar_app/config/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../home/presentation/widgets/general/home_button_widgets.dart';
import '../../domain/entities/product_entities.dart';

Future<int> getLastId() async {
  int id = 0;
  final data = await FirebaseFirestore.instance
      .collection(FireBaseConstants.shopOrders)
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
  GlobalKey<FormState> formKey,
  Function acceptOnTap,
) async {
  controller.text = number;
  String _phoneNumber = '';
  String _countryCode = '';

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
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: IntlPhoneField(
                  controller: controller,
                  invalidNumberMessage:
                      AppStrings.mobileNumberFormatNotCorrect.tr(context),
                      searchText: AppStrings.searchCountry.tr(context),
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorManager.primary,
                  ),
                  decoration: InputDecoration(
                    hintText: title,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    _countryCode = phone.countryCode;
                    _phoneNumber = phone.number;
                  },
                ),
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
                    acceptOnTap();
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
  if (_phoneNumber[0] == '0') {
    _phoneNumber = _phoneNumber.replaceFirst('0', '');
  }

  _phoneNumber = _countryCode + _phoneNumber;
  _phoneNumber.replaceAll(' ', '').replaceAll('-', '').replaceAll('+', '');
  controller.text = _phoneNumber;
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
