import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../home/presentation/blocs/service_order/service_order_bloc.dart';
import '../../../home/presentation/pages/service&company/service_order_view.dart';
import '../bloc/shop_order_bloc/shop_order_bloc.dart';
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
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authState.status == AuthStatus.loggedIn) {
      final user = BlocProvider.of<AuthenticationBloc>(context).state.user!;
      return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.orders.tr(context)),
        ),
        body: Column(
          children: [
            SwitcherWidget(
              executeWhenPressSecond: () {
                BlocProvider.of<ServiceOrderBloc>(context)
                    .add(GetOrders(user: user));
              },
              executeWhenPressFirst: () {
                BlocProvider.of<ShopOrderBloc>(context).add(
                  GetShopOrderEvent(
                    userId: user.id,
                  ),
                );
              },
              onChange: (v) {
                setState(() {
                  isFirst = v;
                });
              },
            ),
            Expanded(
              child: RefreshIndicator(
                color: ColorManager.primary,
                onRefresh: () async {
                  isFirst
                      ? BlocProvider.of<ShopOrderBloc>(context).add(
                          GetShopOrderEvent(
                            userId: user.id,
                          ),
                        )
                      : BlocProvider.of<ServiceOrderBloc>(context)
                          .add(GetOrders(user: user));
                },
                child: AnimatedCrossFade(
                  firstChild: const ShopOrderView(),
                  secondChild: const ServiceOrderView(),
                  crossFadeState: isFirst
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
