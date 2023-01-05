part of 'login_bloc.dart';

enum Status { accepted, notAccepted }

class LoginState extends Equatable {
  final Status status;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;

  const LoginState(
      {this.status = Status.notAccepted,
      this.emailErrorMessage,
      this.passwordErrorMessage});

  LoginState copyWith(
      {Status? status,
      String? emailErrorMessage,
      String? passwordErrorMessage}) {
    status ??= this.status;

    emailErrorMessage ??= this.emailErrorMessage;
    if (emailErrorMessage?.isEmpty ?? false) emailErrorMessage = null;

    passwordErrorMessage ??= this.passwordErrorMessage;
    if (passwordErrorMessage?.isEmpty ?? false) passwordErrorMessage = null;

    return LoginState(
        status: status,
        emailErrorMessage: emailErrorMessage,
        passwordErrorMessage: passwordErrorMessage);
  }

  @override
  List<Object?> get props => [status, emailErrorMessage, passwordErrorMessage];
}
