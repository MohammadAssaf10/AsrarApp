part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

/// called when app start to check if user logged in before
/// 
/// it use the firebase auth package to get user email and firebase store to get his data 
class AppStarted extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
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
