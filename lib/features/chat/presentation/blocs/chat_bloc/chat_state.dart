part of 'chat_bloc.dart';

enum Status { init, loading, success, failed }

class ChatState extends Equatable {
  final Status status;
  final List<Message> messagesList;
  final String? message;

  const ChatState(
    this.status,
    this.messagesList,
    this.message,
  );

  ChatState.init()
      : messagesList = [],
        message = null,
        status = Status.init;

  @override
  List<Object> get props => [status, messagesList, message ?? ''];

  ChatState copyWith({
    Status? status,
    List<Message>? messagesList,
    String? message,
  }) {
    return ChatState(
      status ?? this.status,
      messagesList ?? this.messagesList,
      message,
    );
  }

  @override
  String toString() => 'ChatState(status: $status, messagesList: $messagesList, message: $message)';
}
