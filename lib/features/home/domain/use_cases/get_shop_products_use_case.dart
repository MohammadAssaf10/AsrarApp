import 'package:asrar_app/core/data/exception_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/di.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../entities/product_entities.dart';

class GetShopProductsUseCase {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final NetworkInfo _networkInfo = instance<NetworkInfo>();

  Future<Either<Failure, List<ProductEntities>>> call() async {
    if (await _networkInfo.isConnected) {
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
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }
}
