part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatStarted extends ChatEvent {
  final ServiceOrder serviceOrder;

  ChatStarted({
    required this.serviceOrder,
  });

  @override
  List<Object?> get props => [serviceOrder];
}

class ChatEnded extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class MessageSent extends ChatEvent {
  final TextMessage message;

  MessageSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class _MessageReserved extends ChatEvent {
  final List<Message> messageList;

  _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}
