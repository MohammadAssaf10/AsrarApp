import 'package:flutter/material.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../../home/presentation/pages/service&company/service_order_view.dart';
import '../common/widgets/shop_order_view.dart';
import '../common/widgets/switcher_widget.dart';

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
                isFirst = v;
              });
            },
          ),
          AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: ShopOrderView(),
            secondChild: ServiceOrderView(),
            crossFadeState: isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
