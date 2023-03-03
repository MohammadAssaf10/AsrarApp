import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../shop/presentation/bloc/shop_order_bloc/shop_order_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../widgets/general/navigation_bar_bottom.dart';
import 'customers_service_screen.dart';
import 'home_screen.dart';
import '../../../../shop/presentation/pages/orders_screen.dart';
import 'my_wallet_screen.dart';
import 'profile_screen.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 2);
    return Stack(
      children: [
        Scaffold(
          body: PageView(
            controller: controller,
            onPageChanged: (v) {
              final authState =
                  BlocProvider.of<AuthenticationBloc>(context).state;

              if (v == 4) {
                BlocProvider.of<UserBloc>(context)
                    .add(GetUserInfo(id: authState.user!.id));
              } else if (v == 0) {
                BlocProvider.of<ShopOrderBloc>(context)
                    .add(GetShopOrderEvent(userId: authState.user!.id));
              }
            },
            children: const [
              OrdersScreen(),
              MyWalletScreen(),
              HomeScreen(),
              CustomersServiceScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            color: ColorManager.white,
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
                        controller.jumpToPage(0);
                      },
                    ),
                    NavigationBarBottom(
                      title: AppStrings.myWallet.tr(context),
                      icon: IconAssets.wallet,
                      onPress: () => controller.jumpToPage(1),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavigationBarBottom(
                      title: AppStrings.customerService.tr(context),
                      icon: IconAssets.customersService,
                      onPress: () => controller.jumpToPage(3),
                    ),
                    NavigationBarBottom(
                      title: AppStrings.profile.tr(context),
                      icon: IconAssets.profile,
                      onPress: () {
                        controller.jumpToPage(4);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: GestureDetector(
              onTap: () {
                controller.jumpToPage(2);
              },
              child: Image.asset(
                IconAssets.home,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
