import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../domain/entities/notification.dart';
import '../../../domain/repository/notification_repository.dart';
import 'notification_state.dart';

part 'notification_event.dart';

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
  }
}
