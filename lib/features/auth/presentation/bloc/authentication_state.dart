part of 'authentication_bloc.dart';

enum AuthStatus {
  init,
  loading,
  loggedIn,
  failed,
  resetPasswordSent,
  phoneNumberNeeded,
  verificationCodeNeeded
}

// don' forget to remove '?? this.user' from [copyWith] when regenerate it
class AuthenticationState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? message;

  const AuthenticationState({
    required this.status,
    this.user,
    this.message,
  });

  AuthenticationState copyWith({
    AuthStatus? status,
    User? user,
    String? message,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message,
    );
  }

  @override
  String toString() =>
      'AuthenticationState(status: $status, user: $user, message: $message)';

  @override
  List<Object?> get props => [status, user, message];
}
