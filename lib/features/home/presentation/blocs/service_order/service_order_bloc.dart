import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/entities/service_order.dart';
import '../../../domain/repository/service_order_repository.dart';

part 'service_order_event.dart';
part 'service_order_state.dart';

class ServiceOrderBloc extends Bloc<ServiceOrderEvent, ServiceOrderState> {
  final ServiceOrderRepository _serviceOrderRepository = instance();

  ServiceOrderBloc()
      : super(const ServiceOrderState(
            serviceOrderListStatus: Status.init,
            serviceOrderList: [],
            processStatus: Status.init)) {
    on<GetOrders>((event, emit) async {
      emit(state.copyWith(serviceOrderListStatus: Status.loading));

      (await _serviceOrderRepository.getUserOrder(event.user)).fold(
        (l) {
          emit(state.copyWith(serviceOrderListStatus: Status.failed, message: l.message));
        },
        (r) {
          r.sort((a, b) => (a.id < b.id) ? 1 : 0);

          emit(state.copyWith(serviceOrderListStatus: Status.success, serviceOrderList: r));
        },
      );
    });

    on<AddOrder>((event, emit) async {
      emit(state.copyWith(processStatus: Status.loading));

      (await _serviceOrderRepository.addOrder(event.serviceOrder)).fold(
        (l) {
          emit(state.copyWith(processStatus: Status.failed, message: l.message));
        },
        (r) {
          emit(state.copyWith(processStatus: Status.success));
        },
      );
    });

    on<CancelOrder>((event, emit) async {
      emit(state.copyWith(processStatus: Status.loading));

      (await _serviceOrderRepository.cancelOrder(event.serviceOrder)).fold(
        (l) {
          emit(state.copyWith(processStatus: Status.failed, message: l.message));
        },
        (r) {
          var list = state.serviceOrderList;
          list.remove(event.serviceOrder);
          list.add(event.serviceOrder.copyWith(status: OrderStatus.canceled.name));
          list.sort((a, b) => (a.id < b.id) ? 1 : 0);
          emit(state.copyWith(processStatus: Status.success, serviceOrderList: list));
        },
      );
    });
  }
}
