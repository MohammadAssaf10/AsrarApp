part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class SendNotificationToUser extends NotificationEvent {
  final NotificationInfo notificationInfo;
  const SendNotificationToUser({required this.notificationInfo});
  @override
  List<Object?> get props => [notificationInfo];
}

class SendNotificationToAllUser extends NotificationEvent {
  final NotificationInfo notificationInfo;
  const SendNotificationToAllUser({required this.notificationInfo});
  @override
  List<Object?> get props => [notificationInfo];
}

class GetUserNotifications extends NotificationEvent {
  final String userID;
  const GetUserNotifications({required this.userID});
  @override
  List<Object?> get props => [userID];
}
