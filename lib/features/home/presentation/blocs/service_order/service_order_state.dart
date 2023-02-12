part of 'service_order_bloc.dart';

enum Status { init, loading, success, failed }

/// [processStatus] is for event like [AddOrder] and [CancelOrder]
class ServiceOrderState extends Equatable {
  final Status serviceOrderListStatus;
  final List<ServiceOrder> serviceOrderList;
  final Status processStatus;

  ServiceOrderState({
    required this.serviceOrderListStatus,
    required this.serviceOrderList,
    required this.processStatus,
  });

  @override
  List<Object?> get props => [serviceOrderList, serviceOrderListStatus, processStatus];

  ServiceOrderState copyWith({
    Status? serviceOrderListStatus,
    List<ServiceOrder>? serviceOrderList,
    Status? processStatus,
  }) {
    return ServiceOrderState(
      serviceOrderListStatus: serviceOrderListStatus ?? this.serviceOrderListStatus,
      serviceOrderList: serviceOrderList ?? this.serviceOrderList,
      processStatus: processStatus ?? this.processStatus,
    );
  }
}
