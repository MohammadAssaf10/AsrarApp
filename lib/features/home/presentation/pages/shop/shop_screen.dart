import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/product_bloc/product_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';
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
            showCustomDialog(
              context,
              message: "الرجاء اختيار منتجات",
            );
        },
        backgroundColor: ColorManager.primary,
        child: Icon(
          Icons.shopping_cart_outlined,
          size: AppSize.s25.sp,
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return LoadingView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state is ProductErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state is ProductsLoadedState) {
            if (state.productsList.isNotEmpty) {
              return GridView.builder(
                physics: ScrollPhysics(),
                itemCount: state.productsList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85.h,
                ),
                itemBuilder: (_, int index) {
                  return ProductWidget(
                    product: state.productsList[index],
                  );
                },
              );
            } else 
              return EmptyListView(
                emptyListMessage: AppStrings.noProducts.tr(context),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
              );
            
          }
          return SizedBox();
        },
      ),
    );
  }
}
