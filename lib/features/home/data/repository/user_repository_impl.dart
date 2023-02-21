import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../auth/data/data_sources/firebase_auth_helper.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../../domain/entities/file_entities.dart';
import '../../domain/repository/user_repository.dart';
import '../../../auth/domain/entities/user.dart' as domain;

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuthHelper _authHelper = instance<FirebaseAuthHelper>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthRepository authRepository = instance<AuthRepository>();

  @override
  Future<Either<Failure, Unit>> updateUserImage(
      XFile image, String email) async {
    try {
      final path = "${FireBaseConstants.user}/$email";
      final user = await firestore.collection("Users").doc(email).get();
      if (user['imageURL'] == "" && user['imageName'] == "") {
        final FileEntities file =
            await uploadFile("$path/${image.name}", image);
        await firestore.collection("Users").doc(email).update({
          "imageURL": file.url,
          "imageName": file.name,
        });
      } else {
        await deleteFile("$path/${user['imageName']}");
        final FileEntities file =
            await uploadFile("$path/${image.name}", image);
        await firestore.collection("Users").doc(email).update({
          "imageURL": file.url,
          "imageName": file.name,
        });
      }
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String newPassword) async {
    try {
      final user = _authHelper.getCurrentUser();
      await user?.updatePassword(newPassword);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserInfo(domain.User oldUser,
      String newEmail, String newName, String newPhoneNumber) async {
    try {
      final user = _authHelper.getCurrentUser();
      await user?.updateEmail(newEmail);
      domain.User updatedUser = oldUser.copyWith(
        name: newName,
        email: newEmail,
        phoneNumber: newPhoneNumber,
      );
      await authRepository.updateUserData(updatedUser);
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
