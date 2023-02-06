import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../entities/ad_image_entities.dart';

class GetAdImageUseCase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final NetworkInfo _networkInfo = instance<NetworkInfo>();

  Future<Either<Failure, List<AdImageEntities>>> call() async {
    if (await _networkInfo.isConnected) {
      try {
        List<AdImageEntities> adImagesList = [];
        final adImages = await db.collection(FireBaseCollection.adImages).get();
        for (var doc in adImages.docs)
          adImagesList.add(AdImageEntities.fromMap(doc.data()));
        return Right(adImagesList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
