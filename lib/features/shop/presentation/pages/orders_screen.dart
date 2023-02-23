import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/strings_manager.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../home/presentation/blocs/service_order/service_order_bloc.dart';
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
            executeWhenPressSecond: () {
              final auth = BlocProvider.of<AuthenticationBloc>(context).state;
              BlocProvider.of<ServiceOrderBloc>(context).add(GetOrders(user: auth.user!));
            },
            onChange: (v) {
              setState(() {
                isFirst = v;
              });
            },
          ),
          AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: const ShopOrderView(),
            secondChild: const ServiceOrderView(),
            crossFadeState: isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
