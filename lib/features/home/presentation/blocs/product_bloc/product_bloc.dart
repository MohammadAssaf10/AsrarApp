import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/product_entities.dart';
import '../../../domain/repository/home_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeRepository homeRepository=instance<HomeRepository>();
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsListEvent>((event, emit) async {
      emit(ProductLoadingState());
      (await homeRepository.getShopProducts()).fold((failure) {
        emit(ProductErrorState(errorMessage: failure.message));
      }, (productsList) {
        emit(ProductsLoadedState(productsList: productsList));
      });
    });
  }
}
