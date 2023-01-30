import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product_entities.dart';
import '../../../domain/use_cases/get_shop_products_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetShopProductsUseCase getShopProductsUseCase =
      GetShopProductsUseCase();
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsListEvent>((event, emit) async {
      emit(ProductLoadingState());
      (await getShopProductsUseCase()).fold((failure) {
        emit(ProductErrorState(errorMessage: failure.message));
      }, (productsList) {
        emit(ProductsLoadedState(productsList: productsList));
      });
    });
  }
}
