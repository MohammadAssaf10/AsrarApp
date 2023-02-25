part of 'shop_order_bloc.dart';

abstract class ShopOrderEvent extends Equatable {
  const ShopOrderEvent();
}

class AddShopOrderEvent extends ShopOrderEvent {
  final ShopOrderEntities shopOrder;
  const AddShopOrderEvent({required this.shopOrder});
  @override
  List<Object?> get props => [shopOrder];
}

class CancelShopOrderEvent extends ShopOrderEvent {
  final ShopOrderEntities shopOrder;
  const CancelShopOrderEvent({required this.shopOrder});
  @override
  List<Object?> get props => [shopOrder];
}

class GetShopOrderEvent extends ShopOrderEvent {
  final String userId;
  const GetShopOrderEvent({
    required this.userId,
  });
  @override
  List<Object?> get props => [userId];
}
