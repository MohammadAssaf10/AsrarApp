import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Message {
  Timestamp createdAt;
  String content;

  Message({
    required this.createdAt,
    required this.content,
  });

  factory Message.fromMap(Map map) {
    return TMessage(createdAt: Timestamp.now(), content: map["content"] ?? '');
  }

  @override
  String toString() => 'Message(createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message && other.createdAt == createdAt;
  }

  @override
  int get hashCode => createdAt.hashCode;
}

class TMessage extends Message {
  TMessage({required super.createdAt, required super.content});
}
