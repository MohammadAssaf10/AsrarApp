import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, Unit>> sendNotificationToUser(
      NotificationInfo notificationInfo);
  Future<Either<Failure, Unit>> sendNotificationToAllUser(
      String title, String message);
  Future<Either<Failure, List<NotificationInfo>>> getUserNotifications(
      String userID);
}
