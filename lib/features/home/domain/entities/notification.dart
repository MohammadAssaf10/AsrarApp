import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotificationInfo extends Equatable {
  final String title;
  final String message;
  final String token;
  final String userID;
  final Timestamp timeStamp;

  const NotificationInfo({
    required this.title,
    required this.message,
    required this.token,
    required this.userID,
    required this.timeStamp,
  });

  @override
  List<Object> get props => [title, message, token, userID,timeStamp];

  NotificationInfo copyWith({
    String? title,
    String? message,
    String? token,
    String? userID,
    Timestamp? timeStamp,
  }) {
    return NotificationInfo(
      title: title ?? this.title,
      message: message ?? this.message,
      token: token ?? this.token,
      userID: userID ?? this.userID,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'token': token,
      'userID': userID,
      'timeStamp': timeStamp,
    };
  }

  factory NotificationInfo.fromMap(Map<String, dynamic> map) {
    return NotificationInfo(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      token: map['token'] ?? '',
      userID: map['userID'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
    );
  }

  @override
  String toString() {
    return 'NotificationInfo{title: $title, message: $message, token: $token, userID: $userID, timeStamp: $timeStamp}';
  }
}
