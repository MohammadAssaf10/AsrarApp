import 'package:asrar_app/features/home/domain/entities/company_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';

class GetCompanyUseCase {
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  Future<Either<Failure, List<CompanyEntities>>> call() async {
    if (await _networkInfo.isConnected) {
      try {
        List<CompanyEntities> company = [];
        final FirebaseFirestore db = FirebaseFirestore.instance;
        final data = await db.collection(FireBaseCollection.companies).get();
        for (var doc in data.docs) {
          final CompanyEntities companyEntities = CompanyEntities(
              fullName: doc["fullName"],
              name: doc["name"],
              image: doc["image"]);
          company.add(companyEntities);
        }
        return Right(company);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
