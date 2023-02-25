import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/failure.dart';
import '../../../auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> updateUserImage(XFile image, User user);
  Future<Either<Failure, Unit>> updateUserInfo(
      User oldUser, String newEmail, String newName, String newPhoneNumber);
  Future<Either<Failure, Unit>> updatePassword(String newPassword);
}
