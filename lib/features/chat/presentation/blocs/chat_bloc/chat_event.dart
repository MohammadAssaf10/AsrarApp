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

class TextMessageSent extends ChatEvent {
  final TextMessage message;

  TextMessageSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ImageMessageSent extends ChatEvent {
  final XFile image;

  ImageMessageSent(this.image);
  
  @override
  List<Object?> get props => [];
}

class _MessageReserved extends ChatEvent {
  final List<Message> messageList;

  _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}
