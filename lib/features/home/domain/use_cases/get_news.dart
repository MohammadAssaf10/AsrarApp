import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../entities/news_entities.dart';

class GetNewsUseCase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<Either<Failure, List<NewsEntities>>> call() async {
    try {
      List<NewsEntities> newsList = [];
      final news = await db.collection(FireBaseCollection.news).get();
      for (var doc in news.docs) {
        newsList.add(NewsEntities.fromMap(doc.data()));
      }
      newsList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return Right(newsList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
