import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../entities/service_entities.dart';

class GetServicesUseCase {
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  Future<Either<Failure, List<ServiceEntities>>> call(
      String companyName) async {
    if (await _networkInfo.isConnected) {
      try {
        final List<ServiceEntities> services = [];
        final FirebaseFirestore db = FirebaseFirestore.instance;
        final data = await db.collection(FireBaseCollection.services).get();
        for (var doc in data.docs) {
          if (doc["companyName"] == companyName)
            services.add(ServiceEntities.fromMap(doc.data()));
        }
        return Right(services);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
