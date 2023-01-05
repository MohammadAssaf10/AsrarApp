import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/firebase.dart';
import '../mapper/mapper.dart';
import '../models/requests.dart';
import '../models/responses.dart';

class RepositoryImp implements Repository {
  final FirebaseHelper _firebaseHelper;
  final NetworkInfo _networkInfo;

  RepositoryImp(this._firebaseHelper, this._networkInfo);

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    User user;

    // try to login
    try {
      await _firebaseHelper.login(loginRequest);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    // try to get user data
    try {
      final UserResponse response =
          await _firebaseHelper.getUserData(loginRequest.email);
      user = response.toDomain();
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    return Right(user);
  }

  @override
  Future<Either<Failure, User>> register(
      RegisterRequest registerRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    User user = User(
        name: registerRequest.name,
        email: registerRequest.email,
        mobileNumber: registerRequest.mobileNumber);

    // try to register
    try {
      await _firebaseHelper.register(registerRequest);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    // try to upload user data
    try {
      await _firebaseHelper.updateUserData(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    return Right(user);
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _firebaseHelper.resetPassword(email);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
    return const Right(null);
  }
}
