part of 'chat_bloc.dart';

enum Status { init, loading, success, failed }

class ChatState extends Equatable {
  final Status status;
  final Status fileUploadingStatus;
  final List<Message> messagesList;
  final String? message;

  const ChatState(
    this.status,
    this.messagesList,
    this.message,
    this.fileUploadingStatus,
  );

  ChatState.init()
      : messagesList = [],
        message = null,
        status = Status.init,
        fileUploadingStatus = Status.init;

  @override
  List<Object> get props => [status, messagesList, message ?? '', fileUploadingStatus];

  ChatState copyWith({
    Status? status,
    Status? fileUploadingStatus,
    List<Message>? messagesList,
    String? message,
  }) {
    return ChatState(
      status ?? this.status,
      messagesList ?? this.messagesList,
      message,
      fileUploadingStatus ?? this.fileUploadingStatus,
    );
  }

  @override
  String toString() =>
      'ChatState(status: $status,fileUploading $fileUploadingStatus, messagesList: $messagesList, message: $message)';
}
