import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/product_bloc/product_bloc.dart';
import '../../widgets/shop/product_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("متجر أسرار"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cartList.isNotEmpty)
            Navigator.pushNamed(
              context,
              Routes.cartRoute,
            );
          else
            showCustomDialog(context, message: "الرجاء اختيار منتجات");
        },
        backgroundColor: ColorManager.primary,
        child: Icon(
          Icons.shopping_cart_outlined,
          size: AppSize.s25.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.s100.h,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    ),
                  );
                } else if (state is ProductErrorState) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: AppSize.s60.h),
                    alignment: Alignment.center,
                    child: Text(
                      state.errorMessage.tr(context),
                      style: getAlmaraiRegularStyle(
                        fontSize: AppSize.s20.sp,
                        color: ColorManager.error,
                      ),
                    ),
                  );
                } else if (state is ProductsLoadedState) {
                  if (state.productsList.isNotEmpty) {
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.productsList.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (_, int index) {
                          return ProductWidget(
                            product: state.productsList[index],
                          );
                        });
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: AppSize.s60.h),
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.noServices.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s20.sp,
                          color: ColorManager.error,
                        ),
                      ),
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
