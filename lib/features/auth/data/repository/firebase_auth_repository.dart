import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/firebase_auth_helper.dart';
import '../models/requests.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthHelper _authHelper;
  final NetworkInfo _networkInfo;

  FirebaseAuthRepository(this._authHelper, this._networkInfo);

  @override
  Future<Either<Failure, User>> loginViaEmail(LoginRequest loginRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      await _authHelper.loginViaEmail(loginRequest);

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

  Future<Either<Failure, User>> updateUserData(User user) async {
    try {
      return Right(await _authHelper.updateUserData(user));
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
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

  @override
  Future<Either<Failure, User>> loginViaGoogle() async {
    try {
      final firebaseUser = (await _authHelper.loginViaGoogle()).user!;

      try {
        // the user sign before
        User user = await _authHelper.getUser(firebaseUser.email!);
        return Right(user);
      } catch (e) {
        // first sign create the user
        if (e is firebase.FirebaseAuthException &&
            e.code == "auth/user-not-found") {
          User user = await _authHelper.createUserDocument(firebaseUser);

          return Right(user);
        } else
          rethrow;
      }
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<void> logOut() async {
    await _authHelper.logout();
  }
}