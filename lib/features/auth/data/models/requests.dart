import 'package:equatable/equatable.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String mobileNumber;
  final String password;

  const RegisterRequest(
      this.name, this.email, this.mobileNumber, this.password);

  @override
  List<Object?> get props => [name, email, mobileNumber, password];
}
