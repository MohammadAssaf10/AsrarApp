import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../data/models/requests.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginViaEmail(LoginRequest loginRequest);
  Future<Either<Failure, User>> loginViaGoogle();
  Future<Either<Failure,void>> logOut(String userEmail);
  Future<Either<Failure, void>> sendVerificationCode(
      String number, String message);
  Future<Either<Failure, User>> updateUserData(User user);
  Future<Either<Failure, User>> register(RegisterRequest registerRequest);
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, User?>> getCurrentUserIfExists();
}
