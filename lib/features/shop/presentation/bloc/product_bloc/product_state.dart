part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductErrorState extends ProductState {
  final String errorMessage;
  const ProductErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ProductsLoadedState extends ProductState {
  final List<ProductEntities> productsList;
  const ProductsLoadedState({required this.productsList});
  @override
  List<Object?> get props => [productsList];
}
