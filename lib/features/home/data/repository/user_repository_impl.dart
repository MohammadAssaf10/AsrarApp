import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/data/data_sources/firebase_auth_helper.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../../domain/entities/file_entities.dart';
import '../../domain/repository/user_repository.dart';
import '../../../auth/domain/entities/user.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuthHelper _authHelper = instance<FirebaseAuthHelper>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthRepository authRepository;
  final NetworkInfo networkInfo;
  UserRepositoryImpl({required this.networkInfo, required this.authRepository});

  @override
  Future<Either<Failure, Unit>> updateUserImage(XFile image, User user) async {
    if (await networkInfo.isConnected) {
      try {
        final path = "${FireBaseConstants.user}/${user.id}";
        if (user.imageName.isNotEmpty && user.imageURL.isNotEmpty) {
          await deleteFile("$path/${user.imageName}");
        }
        final FileEntities file =
            await uploadFile("$path/${image.name}", image);
        user = user.copyWith(imageName: file.name, imageURL: file.url);
        await firestore
            .collection(userCollectionPath)
            .doc(user.id)
            .update(user.toMap());
        return const Right(unit);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String newPassword) async {
    if (await networkInfo.isConnected) {
      try {
        final user = _authHelper.getCurrentUser();
        await user?.updatePassword(newPassword);
        return const Right(unit);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserInfo(User oldUser, String newEmail,
      String newName, String newPhoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final user = _authHelper.getCurrentUser();
        await user?.updateEmail(newEmail);
        oldUser = oldUser.copyWith(
          name: newName,
          email: newEmail,
          phoneNumber: newPhoneNumber,
        );
        await authRepository.updateUserData(oldUser);
        return const Right(unit);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }
}
