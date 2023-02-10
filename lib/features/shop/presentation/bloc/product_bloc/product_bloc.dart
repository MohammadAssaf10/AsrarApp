import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../../shop/domain/entities/product_entities.dart';
import '../../../../shop/domain/repositories/shop_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ShopRepository shopRepository = instance<ShopRepository>();
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsListEvent>((event, emit) async {
      emit(ProductLoadingState());
      (await shopRepository.getShopProducts()).fold((failure) {
        emit(ProductErrorState(errorMessage: failure.message));
      }, (productsList) {
        emit(ProductsLoadedState(productsList: productsList));
      });
    });
  }
}
