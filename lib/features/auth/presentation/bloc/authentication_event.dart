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

class GoogleLoginButtonPressed extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class MobileNumberEntered extends AuthenticationEvent {
  final String mobileNumber;
  const MobileNumberEntered({
    required this.mobileNumber,
  });

  @override
  List<Object?> get props => [mobileNumber];

  @override
  String toString() => 'MobileNumberEntered(mobileNumber: $mobileNumber)';
}

class RegisterButtonPressed extends AuthenticationEvent {
  final RegisterRequest registerRequest;

  const RegisterButtonPressed(this.registerRequest);

  @override
  List<Object?> get props => [registerRequest];
}

class ResetPasswordButtonPressed extends AuthenticationEvent {
  final String email;

  const ResetPasswordButtonPressed(this.email);

  @override
  List<Object?> get props => [email];
}

class LogOut extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SendVerificationCode extends AuthenticationEvent {
  final String number;
  final String code;

  const SendVerificationCode(this.number, this.code);
  @override
  List<Object?> get props => [number];
}

class VerificationCodeSubmitted extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUserData extends AuthenticationEvent {
  final User user;

  const UpdateUserData({
    required this.user,
  });
  
  @override
  List<Object?> get props => [user];
  
}
