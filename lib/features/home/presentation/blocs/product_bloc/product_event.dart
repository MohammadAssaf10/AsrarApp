part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductsListEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
