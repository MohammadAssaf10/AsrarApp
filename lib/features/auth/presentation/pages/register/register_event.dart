part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class NameChanged extends RegisterEvent {
  final String? name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class EmailChanged extends RegisterEvent {
  final String? email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class MobileNumberChanged extends RegisterEvent {
  final String? mobileNumber;

  const MobileNumberChanged(this.mobileNumber);

  @override
  List<Object?> get props => [mobileNumber];
}

class PasswordChanged extends RegisterEvent {
  final String? password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}
