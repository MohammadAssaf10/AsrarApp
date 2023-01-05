part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class EmailChanged extends ResetPasswordEvent {
  final String? email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class SendVerificationCodeButtonPressed extends ResetPasswordEvent {
  @override
  List<Object?> get props => [];
}
