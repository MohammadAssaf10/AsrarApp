import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/features/shop/presentation/common/widgets/switcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../common/widgets/shop_order_view.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orders.tr(context)),
      ),
      body: ListView(
        children: [
          SwitcherWidget(
            onChange: (v) {
              setState(() {
                isFirst=v;
              });
            },
          ),
          AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: ShopOrderView(),
            secondChild: Center(
              child: Container(
                color: ColorManager.error,
                height: AppSize.s100.h,
                width: AppSize.s200.w,
              ),
            ),
            crossFadeState:
                isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
