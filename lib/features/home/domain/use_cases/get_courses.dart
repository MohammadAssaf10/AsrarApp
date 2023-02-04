import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../entities/course_entities.dart';

class GetCoursesUseCase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final NetworkInfo _networkInfo = instance<NetworkInfo>();

  Future<Either<Failure, List<CourseEntities>>> call() async {
    if (await _networkInfo.isConnected) {
      try {
        List<CourseEntities> coursesList = [];
        final courses = await db.collection(FireBaseCollection.courses).get();
        for (var doc in courses.docs)
          coursesList.add(CourseEntities.fromMap(doc.data()));
        coursesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Right(coursesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
