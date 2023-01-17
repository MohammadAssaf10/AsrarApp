import 'package:asrar_app/features/home/domain/entities/company_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';

class GetCompanyUseCase {
  Future<Either<Failure, List<CompanyEntities>>> call() async {
    try {
      List<CompanyEntities> company = [];
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final data = await db.collection("company").get();
      for (var doc in data.docs) {
        final CompanyEntities companyEntities =
            CompanyEntities(name: doc["name"], image: doc["image"]);
        company.add(companyEntities);
      }
      return Right(company);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
