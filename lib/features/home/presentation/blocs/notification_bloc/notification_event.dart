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
  final String title;
  final String message;

  const SendNotificationToAllUser({required this.title, required this.message});

  @override
  List<Object?> get props => [title, message];
}

class SendNotificationToGroupOfUser extends NotificationEvent {
  final String title;
  final String message;
  final List<String> tokenList;

  const SendNotificationToGroupOfUser({
    required this.title,
    required this.message,
    required this.tokenList,
  });

  @override
  List<Object?> get props => [title, message, tokenList];
}

class GetUserNotifications extends NotificationEvent {
  final String userID;

  const GetUserNotifications({required this.userID});

  @override
  List<Object?> get props => [userID];
}
