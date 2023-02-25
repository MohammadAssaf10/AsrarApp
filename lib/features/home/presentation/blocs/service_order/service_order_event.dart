part of 'service_order_bloc.dart';

abstract class ServiceOrderEvent extends Equatable {
  const ServiceOrderEvent();
}

class AddOrder extends ServiceOrderEvent {
  final ServiceOrder serviceOrder;
  const AddOrder({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}

class CancelOrder extends ServiceOrderEvent {
  final ServiceOrder serviceOrder;
  const CancelOrder({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}

class CompleteOrder extends ServiceOrderEvent {
  final ServiceOrder serviceOrder;
  CompleteOrder({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}
class GetOrders extends ServiceOrderEvent {
  final User user;
  
  const GetOrders({
    required this.user,
  });
  @override
  List<Object?> get props => [];
}
