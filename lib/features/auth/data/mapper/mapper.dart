import '../../domain/entities/entities.dart';
import '../models/responses.dart';

extension UserResponseExtension on UserResponse {
  User toDomain() {
    return User(
        name: name ?? '', email: email ?? '', mobileNumber: phoneNumber ?? '');
  }
}
