import '../../../../payment/presentation/pages/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/service_entities.dart';
import '../../blocs/service_order/service_order_bloc.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen(this.service, {super.key});
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
              AppStrings.instructions.tr(context),
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
              physics: const ScrollPhysics(),
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
            child: BlocListener<ServiceOrderBloc, ServiceOrderState>(
              listener: (context, state) {
                if (state.processStatus == Status.loading) {
                  showCustomDialog(context);
                } else if (state.processStatus == Status.failed) {
                  showCustomDialog(context, message: state.message!.tr(context));
                } else if (state.processStatus == Status.success) {
                  dismissDialog(context);
                  Navigator.pushNamed(context, Routes.chatRoute,
                      arguments: state.serviceOrderList.first);
                }
              },
              child: PaymentScreen(
                sdkResults: (p0) {
                  print(1);
                  print(2);
                  print(3);
                  print(4);
                  print(p0);
                  print(1);
                  print(2);
                  print(3);
                  print(4);
                },
                customer: Customer(
                  customerId: "",
                  // customer id is important to retrieve cards saved for this customer
                  email: "test@teest.com",
                  isdNumber: "965",
                  number: "00000000",
                  firstName: "test",
                  middleName: "test",
                  lastName: "test",
                  // metaData: null,
                ),
                paymentItems: <PaymentItem>[
                  PaymentItem(
                      name: "item1",
                      amountPerUnit: 12,
                      quantity: Quantity(value: 1),
                      totalAmount: 100),
                ],
              ),
              //  OptionButton(
              //   onTap: () {
              //     // TODO: remove this (but it after the payment screen)

              //     var user = BlocProvider.of<AuthenticationBloc>(context).state.user!;
              //     showConfirmDialog(context, executeWhenConfirm: () {
              //       BlocProvider.of<ServiceOrderBloc>(context).add(AddOrder(
              //           serviceOrder: ServiceOrder(
              //         id: 0,
              //         service: service,
              //         user: user,
              //         status: OrderStatus.pending.name,
              //         employee: Employee.fromMap({}),
              //       )));
              //     });

              //     // TODO: remove comment
              //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PayScreen()));
              //   },
              //   title: AppStrings.checkout.tr(context),
              //   height: AppSize.s35.h,
              //   width: AppSize.s200.w,
              //   fontSize: AppSize.s18.sp,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
