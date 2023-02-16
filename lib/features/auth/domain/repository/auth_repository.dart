import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../data/models/requests.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntities>> loginViaEmail(LoginRequest loginRequest);
  Future<Either<Failure, UserEntities>> loginViaGoogle();
  Future<Either<Failure,void>> logOut(UserEntities user);
  Future<Either<Failure, void>> sendVerificationCode(
      String number, String message);
  Future<Either<Failure, UserEntities>> updateUserData(UserEntities user);
  Future<Either<Failure, UserEntities>> register(RegisterRequest registerRequest);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, UserEntities?>> getCurrentUserIfExists();
}
