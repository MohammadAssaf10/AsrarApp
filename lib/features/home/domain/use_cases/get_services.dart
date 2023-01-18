import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

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
        final data = await db.collection("service").get();
        for (var doc in data.docs) {
          if (doc["companyName"] == companyName) {
            final ServiceEntities serviceEntities = ServiceEntities(
              companyName: doc["companyName"],
              serviceName: doc["serviceName"],
              servicePrice: doc["servicePrice"],
              requiredDocuments: doc["requiredDocuments"],
            );
            services.add(serviceEntities);
            print("Company name:${serviceEntities.companyName}");
            print("Service name:${serviceEntities.serviceName}");
            print("Service price:${serviceEntities.servicePrice}");
            for (String i in serviceEntities.requiredDocuments) {
              print("----->${i}");
            }
          }
        }
        return Right(services);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
