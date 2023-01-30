import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../widgets/home_button_widgets.dart';
import '../widgets/product_widget.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: productsSelectedList.length,
              itemBuilder: (_, int index) {
                return ProductSelectedWidget(
                  product: productsSelectedList[index],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.s10.h,
              ),
              child: OptionButton(
                onTap: () {
                  if (productsSelectedList.isNotEmpty) {
                    final state =
                        BlocProvider.of<AuthenticationBloc>(context).state;
                    if (state is AuthenticationSuccess)
                      showOrderDialog(
                        context,
                        AppStrings.whatsAppNumber.tr(context),
                        AppStrings.whatsAppNumber.tr(context),
                        state.user.phoneNumber,
                        totalProductsPrice.toStringAsFixed(2),
                        () {
                          print("Done");
                          dismissDialog(context);
                        },
                      );
                  } else
                    showCustomDialog(context, message: "الرجاء اختيار منتجات");
                },
                title: AppStrings.addOrder.tr(context),
                height: AppSize.s40.h,
                width: AppSize.s200.w,
                fontSize: AppSize.s22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
