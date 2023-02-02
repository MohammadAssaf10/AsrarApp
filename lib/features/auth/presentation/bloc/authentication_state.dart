part of 'authentication_bloc.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess({
    required this.user,
  });

  @override
  String toString() => 'AuthenticationSuccess(user: $user)';
}

class AuthenticationInProgress extends AuthenticationState {}

class ResetPasswordRequestSuccess extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class PhoneNumberNeeded extends AuthenticationState {
  @override
  String toString() {
    return super.toString();
  }
}
