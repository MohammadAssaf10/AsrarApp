import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../config/strings_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/dio_factory.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repository/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NetworkInfo networkInfo;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NotificationRepositoryImpl({required this.networkInfo});

  final Map<String, dynamic> data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done',
  };
  final Map<String, dynamic> headers = {
    'Authorization': 'key=${FireBaseConstants.serverKey}'
  };

  @override
  Future<Either<Failure, Unit>> sendNotificationToUser(
      NotificationInfo notificationInfo) async {
    if (await networkInfo.isConnected) {
      try {
        // Define the message to send
        final Map<String, dynamic> notification = {
          'title': notificationInfo.title,
          'body': notificationInfo.message,
          'sound': 'default',
        };

        final Map<String, dynamic> body = {
          'notification': notification,
          'data': data,
          'to': notificationInfo.token,
          'priority': 'high',
        };

        // Create a Dio instance
        final Dio dio = await instance<DioFactory>().getDio();

        // Send the message to the FCM API
        final response = await dio.post(
          FireBaseConstants.notificationApi,
          data: jsonEncode(body),
          options: Options(headers: headers),
        );
        if (response.statusCode == 200) {
          await _firestore
              .collection(FireBaseConstants.notifications)
              .add(notificationInfo.toMap());
          return const Right(unit);
        } else {
          final Failure failure = Failure(response.statusCode ?? 0,
              response.statusMessage ?? AppStrings.undefined);
          return Left(failure);
        }
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendNotificationToAllUser(
     String title,String message) async {
    if (await networkInfo.isConnected) {
      try {
        await FirebaseMessaging.instance.subscribeToTopic('all');
        // Define the message to send
        final Map<String, dynamic> notification = {
          'title': title,
          'body': message,
          'sound': 'default',
        };

        final Map<String, dynamic> body = {
          'notification': notification,
          'data': data,
          'to': '/topics/all',
          'topic': "all",
          'priority': 'high',
        };

        // Create a Dio instance
        final Dio dio = await instance<DioFactory>().getDio();

        // Send the message to the FCM API
        final response = await dio.post(
          FireBaseConstants.notificationApi,
          data: jsonEncode(body),
          options: Options(headers: headers),
        );
        if (response.statusCode == 200) {
          return const Right(unit);
        } else {
          final Failure failure = Failure(response.statusCode ?? 0,
              response.statusMessage ?? AppStrings.undefined);
          return Left(failure);
        }
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }
}
