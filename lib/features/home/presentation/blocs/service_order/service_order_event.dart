part of 'service_order_bloc.dart';

abstract class ServiceOrderEvent extends Equatable {
  const ServiceOrderEvent();
}

class AddOrder extends ServiceOrderEvent {
  final ServiceOrder serviceOrder;
  AddOrder({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}

class CancelOrder extends ServiceOrderEvent {
  final ServiceOrder serviceOrder;
  CancelOrder({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}

class GetOrders extends ServiceOrderEvent {
  final User user;
  
  GetOrders({
    required this.user,
  });
  @override
  List<Object?> get props => [];
}
