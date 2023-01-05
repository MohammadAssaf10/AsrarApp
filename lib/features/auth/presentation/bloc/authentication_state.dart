part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationInProgress extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordRequestSuccess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
