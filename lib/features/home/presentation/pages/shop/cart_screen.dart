import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../widgets/general/home_button_widgets.dart';
import '../../widgets/shop/product_widget.dart';
import '../pay/pay_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.cart.tr(context)),
      ),
      body: ListView(
        children: [
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartList.length,
            itemBuilder: (_, int index) {
              return cartWidget(
                product: cartList[index],
              );
            },
          ),
          OptionButton(
            onTap: () {
              if (cartList.isNotEmpty) {
                final state =
                    BlocProvider.of<AuthenticationBloc>(context).state;
                if (state.status == AuthStatus.loggedIn)
                  showOrderDialog(
                    context,
                    AppStrings.whatsAppNumber.tr(context),
                    state.user!.phoneNumber,
                    dp(totalProductsPrice, 2).toString(),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayScreen(),
                        ),
                      );
                    },
                  );
              }
            },
            title: AppStrings.addOrder.tr(context),
            height: AppSize.s40.h,
            width: AppSize.s200.w,
            fontSize:AppSize.s22.sp
          ),
        ],
      ),
    );
  }
}
