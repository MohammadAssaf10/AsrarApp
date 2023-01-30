import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class LoginRequest extends Equatable {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequest extends User {
  final String password;

  RegisterRequest({required super.name, required super.email, required this.password, required super.phoneNumber});
}
