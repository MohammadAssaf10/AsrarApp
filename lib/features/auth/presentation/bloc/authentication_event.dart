part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoginButtonPressed extends AuthenticationEvent {
  final LoginRequest loginRequest;

  const LoginButtonPressed(this.loginRequest);

  @override
  List<Object?> get props => [loginRequest];
}

class RegisterButtonPressed extends AuthenticationEvent {
  final RegisterRequest registerRequest;

  const RegisterButtonPressed(this.registerRequest);

  @override
  List<Object?> get props => [registerRequest];
}

class SendVerificationCodeButtonPressed extends AuthenticationEvent {
  final String email;

  const SendVerificationCodeButtonPressed(this.email);

  @override
  List<Object?> get props => [email];
}
