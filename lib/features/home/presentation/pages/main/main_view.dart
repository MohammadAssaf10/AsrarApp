import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/di.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../chat/presentation/blocs/support_chat/support_chat_bloc.dart';
import '../../../../shop/presentation/bloc/shop_order_bloc/shop_order_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../widgets/general/navigation_bar_bottom.dart';
import 'support_screen.dart';
import 'home_screen.dart';
import '../../../../shop/presentation/pages/orders_screen.dart';
import 'my_wallet_screen.dart';
import 'profile_screen.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 2);
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    return Stack(
      children: [
        Scaffold(
          body: PageView(
            controller: controller,
            onPageChanged: (v) {
              if (v == 4) {
                if (authState.status == AuthStatus.loggedIn) {
                  BlocProvider.of<UserBloc>(context)
                      .add(GetUserInfo(id: authState.user!.id));
                  controller.jumpToPage(4);
                } else {
                  showLoginDialog(context);
                  controller.jumpToPage(2);
                }
              }
              else if (v == 0) {
                if (authState.status == AuthStatus.loggedIn) {
                  BlocProvider.of<ShopOrderBloc>(context)
                      .add(GetShopOrderEvent(userId: authState.user!.id));
                  controller.jumpToPage(0);
                } else {
                  showLoginDialog(context);
                  controller.jumpToPage(2);
                }
              }
              // if (v == 4 && authState.status == AuthStatus.loggedIn) {
              //   BlocProvider.of<UserBloc>(context)
              //       .add(GetUserInfo(id: authState.user!.id));
              // } else if (v == 0 && authState.status == AuthStatus.loggedIn) {
              //   BlocProvider.of<ShopOrderBloc>(context)
              //       .add(GetShopOrderEvent(userId: authState.user!.id));
              // } else if (v == 3 && authState.status == AuthStatus.loggedIn) {
              //   initSupportChatModule(authState.user!);
              //   BlocProvider.of<SupportChatBloc>(context).add(ChatStarted());
              // } else if (v == 2) {
              // } else {
              //   showLoginDialog(context);
              // }
            },
            children: const [
              OrdersScreen(),
              MyWalletScreen(),
              HomeScreen(),
              SupportScreen(),
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
                        if (authState.status == AuthStatus.loggedIn) {
                          controller.jumpToPage(0);
                        } else {
                          showLoginDialog(context);
                        }
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
                      title: AppStrings.support.tr(context),
                      icon: IconAssets.customersService,
                      onPress: () {
                        controller.jumpToPage(3);
                      },
                    ),
                    NavigationBarBottom(
                      title: AppStrings.profile.tr(context),
                      icon: IconAssets.profile,
                      onPress: () {
                        if (authState.status == AuthStatus.loggedIn) {
                          controller.jumpToPage(4);
                        } else {
                          showLoginDialog(context);
                        }
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
