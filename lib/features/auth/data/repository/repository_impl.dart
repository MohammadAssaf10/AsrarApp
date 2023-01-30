import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/repository.dart';
import '../data_sources/firebase.dart';
import '../models/requests.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthHelper _authHelper;
  final NetworkInfo _networkInfo;

  FirebaseAuthRepository(this._authHelper, this._networkInfo);

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      await _authHelper.login(loginRequest);

      User user = await _authHelper.getUser(loginRequest.email);
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, User>> register(
      RegisterRequest registerRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    // try to register
    try {
      await _authHelper.register(registerRequest);

      await _authHelper.updateUserData(registerRequest);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    return Right(registerRequest);
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _authHelper.resetPassword(email);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, User?>> getCurrentUserIfExists() async {
    try {
      firebase.User? firebaseUser = _authHelper.getCurrentUser();

      if (firebaseUser == null) return const Right(null);

      User user = await _authHelper.getUser(firebaseUser.email!);

      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
