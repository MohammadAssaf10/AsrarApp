import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> updateUserImage(XFile image, String email);
  Future<Either<Failure, Unit>> updatePassword(String newPassword);
}
