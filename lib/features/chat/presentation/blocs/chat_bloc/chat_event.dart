part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatStarted extends ChatEvent {
  final ServiceOrder serviceOrder;

  const ChatStarted({
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

  const TextMessageSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ImageMessageSent extends ChatEvent {
  final ImageMessage message;
  final XFile image;

  const ImageMessageSent(this.image, this.message);

  @override
  List<Object?> get props => [image, message];
}
class VoiceMessageSent extends ChatEvent {
  final VoiceMessage message;
  final XFile voice;

  const VoiceMessageSent(this.voice, this.message);

  @override
  List<Object?> get props => [voice, message];
}

class _MessageReserved extends ChatEvent {
  final List<Message> messageList;

  const _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}
