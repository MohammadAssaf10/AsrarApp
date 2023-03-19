import 'package:equatable/equatable.dart';

class NotificationInfo extends Equatable {
  final String title;
  final String message;
  final String token;
  final String userID;
  const NotificationInfo(
      {required this.title,
      required this.message,
      required this.token,
      required this.userID});
  @override
  List<Object> get props => [title, message, token, userID];

  NotificationInfo copyWith({
    String? title,
    String? message,
    String? token,
    String? userID,
  }) {
    return NotificationInfo(
      title: title ?? this.title,
      message: message ?? this.message,
      token: token ?? this.token,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'token': token,
      'userID': userID,
    };
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    return NotificationInfo(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      token: map['token'] ?? '',
      userID: map['userID'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NotificationInfo(title: $title, message: $message, token: $token, userID: $userID)';
  }
}
