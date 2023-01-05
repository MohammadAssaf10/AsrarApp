import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/assets_manager.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../widgets/navigation_bar_bottom.dart';
import 'customers_service_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'my_wallet_screen.dart';
import 'profile_screen.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget _currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: _currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.transparent,
        elevation: 0.0,
        highlightElevation: 0.0,
        onPressed: () {
          setState(() {
            _currentScreen = HomeScreen();
          });
        },
        child: Image.asset(
          IconAssets.home,
          height: double.infinity,
          width: double.infinity,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
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
                    onPress: () {
                      setState(() {
                        _currentScreen = OrdersScreen();
                      });
                    },
                  ),
                  NavigationBarBottom(
                    title: AppStrings.myWallet.tr(context),
                    icon: IconAssets.wallet,
                    onPress: () {
                      setState(() {
                        _currentScreen = MyWalletScreen();
                      });
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationBarBottom(
                    title: AppStrings.customerService.tr(context),
                    icon: IconAssets.customersService,
                    onPress: () {
                      setState(() {
                        _currentScreen = CustomersServiceScreen();
                      });
                    },
                  ),
                  NavigationBarBottom(
                    title: AppStrings.profile.tr(context),
                    icon: IconAssets.profile,
                    onPress: () {
                      setState(() {
                        _currentScreen = ProfileScreen();
                      });
                    },
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
