part of 'support_chat_bloc.dart';

class SupportChatState extends Equatable {
  final Status status;
  final Status fileUploadingStatus;
  final List<Message> messagesList;
  final String? message;

  const SupportChatState(
      this.status,
      this.messagesList,
      this.message,
      this.fileUploadingStatus,
      );

  SupportChatState.init()
      : messagesList = [],
        message = null,
        status = Status.init,
        fileUploadingStatus = Status.init;

  @override
  List<Object> get props => [status, messagesList, message ?? '', fileUploadingStatus];

  SupportChatState copyWith({
    Status? status,
    Status? fileUploadingStatus,
    List<Message>? messagesList,
    String? message,
  }) {
    return SupportChatState(
      status ?? this.status,
      messagesList ?? this.messagesList,
      message,
      fileUploadingStatus ?? this.fileUploadingStatus,
    );
  }

  @override
  String toString() =>
      'SupportChatState(status: $status,fileUploading $fileUploadingStatus, messagesList: $messagesList, message: $message)';

}