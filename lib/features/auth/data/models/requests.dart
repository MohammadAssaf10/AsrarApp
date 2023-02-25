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

  RegisterRequest({
    required super.id,
    required super.name,
    required super.email,
    required this.password,
    required super.phoneNumber,
    required super.userTokenList,
    required super.imageURL,
    required super.imageName,
  });

  @override
  RegisterRequest copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? imageURL,
    String? imageName,
    List<String>? userTokenList,
  }) {
    return RegisterRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageURL: imageURL ?? this.imageURL,
      imageName: imageName ?? this.imageName,
      userTokenList: userTokenList ?? this.userTokenList,
    );
  }
}
