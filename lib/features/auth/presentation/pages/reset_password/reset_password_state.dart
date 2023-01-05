part of 'reset_password_bloc.dart';

enum Status { accepted, notAccepted }

class ResetPasswordState extends Equatable {
  final Status emailStatus;
  final bool isSendVerificationButton;
  final Status verificationCodeStatus;
  final String? emailErrorMessage;

  const ResetPasswordState(
      {this.isSendVerificationButton = false,
      this.emailStatus = Status.notAccepted,
      this.verificationCodeStatus = Status.notAccepted,
      this.emailErrorMessage});

  ResetPasswordState copyWith(
      {Status? emailStatus,
      Status? verificationCodeStatus,
      String? emailErrorMessage,
      bool? isSendVerificationButton}) {
    isSendVerificationButton ??= this.isSendVerificationButton;

    emailErrorMessage ??= this.emailErrorMessage;
    if (emailErrorMessage?.isEmpty ?? false) emailErrorMessage = null;

    return ResetPasswordState(
        isSendVerificationButton: isSendVerificationButton,
        emailStatus: emailStatus ?? this.emailStatus,
        verificationCodeStatus:
            verificationCodeStatus ?? this.verificationCodeStatus,
        emailErrorMessage: emailErrorMessage);
  }

  @override
  List<Object?> get props => [
        emailStatus,
        verificationCodeStatus,
        emailErrorMessage,
        isSendVerificationButton
      ];
}
