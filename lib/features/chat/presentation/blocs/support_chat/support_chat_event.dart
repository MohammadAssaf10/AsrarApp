part of 'support_chat_bloc.dart';

abstract class SupportChatEvent extends Equatable {
  const SupportChatEvent();
}

class ChatStarted extends SupportChatEvent {
  @override
  List<Object?> get props => [];
}

class ChatEnded extends SupportChatEvent {
  @override
  List<Object?> get props => [];
}

class TextMessageSent extends SupportChatEvent {
  final TextMessage message;

  const TextMessageSent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ImageMessageSent extends SupportChatEvent {
  final ImageMessage message;
  final XFile image;

  const ImageMessageSent(this.image, this.message);

  @override
  List<Object?> get props => [image, message];
}

class VoiceMessageSent extends SupportChatEvent {
  final VoiceMessage message;
  final XFile voice;

  const VoiceMessageSent(this.voice, this.message);

  @override
  List<Object?> get props => [voice, message];
}

class _MessageReserved extends SupportChatEvent {
  final List<Message> messageList;

  const _MessageReserved({
    required this.messageList,
  });

  @override
  List<Object?> get props => [messageList];
}
