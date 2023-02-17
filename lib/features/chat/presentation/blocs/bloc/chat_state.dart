part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<Message> messagesList;

  const ChatState(
    this.messagesList,
  );

  ChatState.init() : messagesList = [];

  @override
  List<Object> get props => [messagesList];

  ChatState copyWith({
    List<Message>? messagesList,
  }) {
    return ChatState(
      messagesList ?? this.messagesList,
    );
  }

  @override
  String toString() => 'ChatState(messagesList: $messagesList)';
}
