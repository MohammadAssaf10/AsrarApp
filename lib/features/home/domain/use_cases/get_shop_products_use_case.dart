import 'package:asrar_app/core/data/exception_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/failure.dart';
import '../entities/product_entities.dart';

class GetShopProductsUseCase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Future<Either<Failure, List<ProductEntities>>> call() async {
    try {
      List<ProductEntities> productsList = [];
      final products = await db.collection(FireBaseCollection.products).get();
      for (var doc in products.docs) {
        productsList.add(ProductEntities.fromMap(doc.data()));
      }
      return Right(productsList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
