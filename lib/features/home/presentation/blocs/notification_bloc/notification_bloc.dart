import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/repository/notification_repository.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository =
      instance<NotificationRepository>();

  NotificationBloc() : super(const NotificationState()) {
    on<SendNotificationToUser>((event, emit) async {
      (await _notificationRepository
              .sendNotificationToUser(event.notificationInfo))
          .fold((failure) {
        emit(state.copyWith(
          notificationStatus: NotificationStatus.error,
          errorMessage: failure.message,
        ));
      }, (r) {
        emit(state.copyWith(notificationStatus: NotificationStatus.sended));
      });
    });
    on<SendNotificationToAllUser>((event, emit) async {
      (await _notificationRepository.sendNotificationToAllUser(
              event.title, event.message))
          .fold((l) {}, (r) {
        emit(state.copyWith(notificationStatus: NotificationStatus.sended));
      });
    });
    on<GetUserNotifications>((event, emit) async {
      emit(state.copyWith(notificationStatus: NotificationStatus.loading));
      (await _notificationRepository.getUserNotifications(event.userID)).fold(
          (failure) {
        emit(state.copyWith(
          notificationStatus: NotificationStatus.error,
          errorMessage: failure.message,
        ));
      }, (notificationList) {
        emit(state.copyWith(
            notificationStatus: NotificationStatus.success,
            notificationList: notificationList));
      });
    });
    on<SendNotificationToGroupOfUser>((event, emit) async {
      (await _notificationRepository.sendNotificationToGroupOfUser(
              event.title, event.message, event.tokenList))
          .fold((l) {}, (r) {
        emit(state.copyWith(notificationStatus: NotificationStatus.sended));
      });
    });
  }
}
