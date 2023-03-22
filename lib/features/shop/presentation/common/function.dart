import 'package:asrar_app/config/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/styles_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../home/presentation/widgets/general/home_button_widgets.dart';
import '../../../payment/presentation/widgets/payment_button.dart';
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
  List<ProductEntities> cartList,
  GlobalKey<FormState> formKey,
  User user,
  List<ProductEntities> products,
  Function(String completePhoneNumber,String chargeId) acceptOnTap,
) async {
  String phoneNumber = number;
  String countryCode = '966';
  final TextEditingController controller = TextEditingController(text: number);
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
                  // ignore: deprecated_member_use
                  searchText: AppStrings.searchCountry.tr(context),
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorManager.primary,
                  ),
                  decoration: InputDecoration(
                    hintText: title,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    countryCode = phone.countryCode;
                    phoneNumber = phone.number;
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
                SizedBox(
                  height: AppSize.s35.h,
                  width: AppSize.s120.w,
                  child: PaymentButton(
                    onSuccess: (chargeInfo) {
                      if (phoneNumber[0] == '0') {
                        phoneNumber = phoneNumber.replaceFirst('0', '');
                      }
                      phoneNumber = countryCode + phoneNumber;
                      acceptOnTap(phoneNumber.replaceAll('+', ''),chargeInfo.charge_id);
                      if (user.tapId.isEmpty) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          UpdateUserData(
                            user: user.copyWith(tapId: chargeInfo.customer_id),
                          ),
                        );
                      }
                    },
                    customer: Customer(
                      customerId: user.tapId,
                      email: user.email,
                      isdNumber: "",
                      number: phoneNumber,
                      firstName: user.name,
                      middleName: "",
                      lastName: "",
                    ),
                    paymentItems: convertToPaymentItem(products),
                    onFailed: (message) {
                      showCustomDialog(context, message: message.tr(context));
                    },
                  ),
                ),
                // OptionButton(
                //   onTap: () {
                //     if (phoneNumber[0] == '0') {
                //       phoneNumber = phoneNumber.replaceFirst('0', '');
                //     }
                //     phoneNumber = countryCode + phoneNumber;
                //     phoneNumber
                //         .replaceAll(' ', '')
                //         .replaceAll('-', '')
                //         .replaceAll('+', '');
                //     acceptOnTap(phoneNumber);
                //   },
                //   title: AppStrings.checkout.tr(context),
                //   height: AppSize.s35.h,
                //   width: AppSize.s120.w,
                //   fontSize: AppSize.s18.sp,
                // ),
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

List<PaymentItem> convertToPaymentItem(List<ProductEntities> products) {
  List<PaymentItem> items = [];
  for (ProductEntities product in products) {
    PaymentItem paymentItem = PaymentItem(
      name: product.productName,
      amountPerUnit: stringToDouble(product.productPrice),
      quantity: Quantity(value: product.productCount),
      totalAmount: 0,
    );
    items.add(paymentItem);
  }
  return items;
}

int getTotalProductsPrice(List<ProductEntities> cartList) {
  int totalPrice = 0;
  for (var product in cartList) {
    totalPrice = totalPrice +
        (product.productCount * int.parse(product.productPrice));
  }
  return totalPrice;
}
