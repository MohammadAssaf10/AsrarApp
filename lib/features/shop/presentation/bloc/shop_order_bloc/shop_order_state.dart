part of 'shop_order_bloc.dart';

abstract class ShopOrderState extends Equatable {
  const ShopOrderState();
}

class ShopOrderInitial extends ShopOrderState {
  @override
  List<Object?> get props => [];
}

class ShopOrderLoadingState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}
class CancelShopOrderLoadingState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}

class ShopOrderErrorState extends ShopOrderState {
  final String errorMessage;
  const ShopOrderErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
class CancelShopOrderErrorState extends ShopOrderState {
  final String errorMessage;
  const CancelShopOrderErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class ShopOrderLoadedState extends ShopOrderState {
  final List<ShopOrderEntities> shopOrderList;
  const ShopOrderLoadedState({required this.shopOrderList});
  @override
  List<Object?> get props => [shopOrderList];
}

class ShopOrderAddedSuccessfullyState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}
class ShopOrderCancelledSuccessfullyState extends ShopOrderState {
  @override
  List<Object?> get props => [];
}
