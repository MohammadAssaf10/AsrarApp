import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/routes_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../domain/entities/product_entities.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../../../home/presentation/widgets/general/empty_list_view.dart';
import '../../../home/presentation/widgets/general/error_view.dart';
import '../../../home/presentation/widgets/general/loading_view.dart';
import '../common/widgets/product_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductEntities> cartList = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.asrarShop.tr(context)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cartList.isNotEmpty) {
            Navigator.pushNamed(
              context,
              Routes.cartRoute,
              arguments: cartList,
            );
          } else {
            showCustomDialog(
              context,
              message: AppStrings.pleaseChooseProducts.tr(context),
            );
          }
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
                itemCount: state.productsList.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, int index) {
                  return ProductWidget(
                    product: state.productsList[index],
                    addToList: () {
                      cartList.add(state.productsList[index]);
                    },
                    deleteFromList: () {
                      cartList.remove(state.productsList[index]);
                    },
                  );
                },
              );
            } else {
              return EmptyListView(
                emptyListMessage: AppStrings.noProducts.tr(context),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
