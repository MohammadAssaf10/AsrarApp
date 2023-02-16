import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_preference.dart';
import '../data_sources/firebase_auth_helper.dart';
import '../data_sources/whatsapp_api.dart';
import '../models/requests.dart';

class registering implements AuthRepository {
  final FirebaseAuthHelper _authHelper;
  final NetworkInfo _networkInfo;
  final WhatsappApi _whatsappApi;
  final AuthPreference _authPreference;

  registering(this._authHelper, this._networkInfo, this._whatsappApi,
      this._authPreference);

  @override
  Future<Either<Failure, UserEntities>> loginViaEmail(
      LoginRequest loginRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      await _authHelper.loginViaEmail(loginRequest);

      UserEntities user = await _authHelper.getUser(loginRequest.email);
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UserEntities>> register(
      RegisterRequest registerRequest) async {
    // check internet connection
    if (!(await _networkInfo.isConnected)) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    // try to register
    try {
      await _authHelper.register(registerRequest);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }

    return Right(registerRequest);
  }

  // this method called in every signIn or registering
  // because if it from google it can be the first sign in
  Future<Either<Failure, UserEntities>> updateUserData(
      UserEntities user) async {
    try {
      _authPreference.setUserLoggedIn();
      _authPreference.setUser(user);
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
  Future<Either<Failure, UserEntities?>> getCurrentUserIfExists() async {
    try {
      if (!_authPreference.isUserLoggedIn()) return const Right(null);

      UserEntities user = _authPreference.getUser();
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UserEntities>> loginViaGoogle() async {
    try {
      final firebaseUser = (await _authHelper.loginViaGoogle()).user!;

      try {
        // the user sign before
        UserEntities user = await _authHelper.getUser(firebaseUser.email!);
        return Right(user);
      } catch (e) {
        // first sign create the user
        if (e is firebase.FirebaseAuthException &&
            e.code == "auth/user-not-found") {
          UserEntities user = UserEntities(
              name: firebaseUser.displayName!,
              email: firebaseUser.email!,
              phoneNumber: '',
              userTokenList: []);

          return Right(user);
        } else
          rethrow;
      }
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logOut(UserEntities user) async {
    try {
      _authPreference.setUserLoggedOut();
      await _authHelper.logout(user);
      return const Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> sendVerificationCode(
      String number, String code) async {
    try {
      await _whatsappApi.sendCode(
          number: number,
          message: 'رمز التحقق الخاص بك هو: $code',
          instance_id: WhatsAppApiConstance.instance.instance_id,
          access_token: WhatsAppApiConstance.instance.access_token);
      return Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
