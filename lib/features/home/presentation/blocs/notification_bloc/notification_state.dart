import 'package:equatable/equatable.dart';

import '../../../domain/entities/notification.dart';

enum NotificationStatus { initial, loading, error, success,sended }

class NotificationState extends Equatable {
  final NotificationStatus notificationStatus;
  final String errorMessage;
  final List<NotificationInfo> notificationList;
  const NotificationState({
    this.notificationStatus = NotificationStatus.initial,
    this.errorMessage = "",
    this.notificationList = const [],
  });

  @override
  List<Object> get props =>
      [notificationStatus, errorMessage, notificationList];

  @override
  String toString() =>
      'NotificationState(notificationStatus: $notificationStatus, errorMessage: $errorMessage, notificationList: $notificationList)';

  NotificationState copyWith({
    NotificationStatus? notificationStatus,
    String? errorMessage,
    List<NotificationInfo>? notificationList,
  }) {
    return NotificationState(
      notificationStatus: notificationStatus ?? this.notificationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      notificationList: notificationList ?? this.notificationList,
    );
  }
}
