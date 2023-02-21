part of 'shop_order_bloc.dart';

abstract class ShopOrderEvent extends Equatable {
  const ShopOrderEvent();
}

class AddShopOrderEvent extends ShopOrderEvent {
  final ShopOrderEntities shopOrder;
  AddShopOrderEvent({required this.shopOrder});
  @override
  List<Object?> get props => [shopOrder];
}

class CancelShopOrderEvent extends ShopOrderEvent {
  final ShopOrderEntities shopOrder;
  CancelShopOrderEvent({required this.shopOrder});
  @override
  List<Object?> get props => [shopOrder];
}

class GetShopOrderEvent extends ShopOrderEvent {
  final String userId;
  GetShopOrderEvent({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}
