part of 'register_bloc.dart';

enum Status { accepted, notAccepted }

class RegisterState extends Equatable {
  final Status status;
  final String? nameErrorMessage;
  final String? emailErrorMessage;
  final String? mobileNumberErrorMessage;
  final String? passwordErrorMessage;

  const RegisterState(
      {this.status = Status.notAccepted,
      this.nameErrorMessage,
      this.emailErrorMessage,
      this.mobileNumberErrorMessage,
      this.passwordErrorMessage});

  RegisterState copyWith(
      {Status? status,
      String? nameErrorMessage,
      String? emailErrorMessage,
      String? mobileNumberErrorMessage,
      String? passwordErrorMessage}) {
    status ??= this.status;

    nameErrorMessage ??= this.nameErrorMessage;
    if (nameErrorMessage?.isEmpty ?? false) nameErrorMessage = null;

    emailErrorMessage ??= this.emailErrorMessage;
    if (emailErrorMessage?.isEmpty ?? false) emailErrorMessage = null;

    mobileNumberErrorMessage ??= this.mobileNumberErrorMessage;
    if (mobileNumberErrorMessage?.isEmpty ?? false) {
      mobileNumberErrorMessage = null;
    }

    passwordErrorMessage ??= this.passwordErrorMessage;
    if (passwordErrorMessage?.isEmpty ?? false) passwordErrorMessage = null;

    return RegisterState(
        status: status,
        nameErrorMessage: nameErrorMessage,
        emailErrorMessage: emailErrorMessage,
        mobileNumberErrorMessage: mobileNumberErrorMessage,
        passwordErrorMessage: passwordErrorMessage);
  }

  @override
  List<Object?> get props => [
        status,
        nameErrorMessage,
        emailErrorMessage,
        mobileNumberErrorMessage,
        passwordErrorMessage
      ];
}
