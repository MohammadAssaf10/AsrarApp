import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure,Unit>> sendNotificationToGroupOfUser(
      List<String> tokens, String title, String message);
  Future<Either<Failure,Unit>> sendNotificationToAllUser(
       String title, String message);
}
