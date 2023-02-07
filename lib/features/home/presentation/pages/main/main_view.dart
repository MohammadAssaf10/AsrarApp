import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/assets_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../widgets/general/navigation_bar_bottom.dart';
import 'customers_service_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'my_wallet_screen.dart';
import 'profile_screen.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: 2);
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          OrdersScreen(),
          MyWalletScreen(),
          HomeScreen(),
          CustomersServiceScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: MaterialButton(
        onPressed: () => _controller.jumpToPage(2),
        child: Image.asset(
          IconAssets.home,
          filterQuality: FilterQuality.high,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: AppSize.s50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationBarBottom(
                    title: AppStrings.orders.tr(context),
                    icon: IconAssets.orders,
                    onPress: () => _controller.jumpToPage(0),
                  ),
                  NavigationBarBottom(
                    title: AppStrings.myWallet.tr(context),
                    icon: IconAssets.wallet,
                    onPress: () => _controller.jumpToPage(1),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationBarBottom(
                    title: AppStrings.customerService.tr(context),
                    icon: IconAssets.customersService,
                    onPress: () => _controller.jumpToPage(3),
                  ),
                  NavigationBarBottom(
                    title: AppStrings.profile.tr(context),
                    icon: IconAssets.profile,
                    onPress: () => _controller.jumpToPage(4),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
