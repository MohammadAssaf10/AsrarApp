part of 'authentication_bloc.dart';

abstract class AuthenticationStateA {}

class AuthenticationInitial extends AuthenticationStateA {}

class AuthenticationSuccess extends AuthenticationStateA {
  final User user;

  AuthenticationSuccess({
    required this.user,
  });

  @override
  String toString() => 'AuthenticationSuccess(user: $user)';
}

class AuthenticationInProgress extends AuthenticationStateA {
  final User? user;
  AuthenticationInProgress({
    this.user,
  });

  @override
  String toString() => 'AuthenticationInProgress(user: $user)';
}

class ResetPasswordRequestSuccess extends AuthenticationStateA {}

class AuthenticationFailed extends AuthenticationStateA {
  final String message;

  AuthenticationFailed(this.message);
}

class PhoneNumberNeeded extends AuthenticationInProgress {
  PhoneNumberNeeded({
    required super.user,
  });
  @override
  String toString() => 'PhoneNumberNeeded(user: $user)';
}

class VerificationCodeNeeded extends AuthenticationInProgress {
  VerificationCodeNeeded({
    required super.user,
  });

  @override
  String toString() => 'VerificationCodeNeeded(user: $user)';
}

enum AuthStatus {
  init,
  loading,
  success,
  failed,
  phoneNumberNeeded,
  verificationCodeNeeded
}

class AuthenticationState {
  final AuthStatus status;
  final User? user;
  
  AuthenticationState({
    required this.status,
    this.user,
  });

  AuthenticationState copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  String toString() => 'AuthenticationState(status: $status, user: $user)';
}
