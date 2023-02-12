part of 'service_order_bloc.dart';

enum Status { init, loading, success, failed }

/// [processStatus] is for event like [AddOrder] and [CancelOrder]
// * if for some reason regenerate data class is needed
// - in [copyWith] remove the ?? in message
class ServiceOrderState extends Equatable {
  final Status serviceOrderListStatus;
  final List<ServiceOrder> serviceOrderList;
  final Status processStatus;
  final String? message;

  ServiceOrderState({
    required this.serviceOrderListStatus,
    required this.serviceOrderList,
    required this.processStatus,
    this.message,
  });

  @override
  List<Object?> get props => [
        serviceOrderListStatus,
        processStatus,
        serviceOrderList,
      ];

  ServiceOrderState copyWith({
    Status? serviceOrderListStatus,
    List<ServiceOrder>? serviceOrderList,
    Status? processStatus,
    String? message,
  }) {
    return ServiceOrderState(
      serviceOrderListStatus: serviceOrderListStatus ?? this.serviceOrderListStatus,
      serviceOrderList: serviceOrderList ?? this.serviceOrderList,
      processStatus: processStatus ?? this.processStatus,
      message: message,
    );
  }
}
