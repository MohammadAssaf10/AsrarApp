import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
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
                  showOrderDialog(
                    context,
                    AppStrings.whatsAppNumber.tr(context),
                    AppStrings.whatsAppNumber.tr(context),
                    "0997806274",
                    () {
                      print("Done");
                    },
                  );
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
