import 'package:asrar_app/features/shop/domain/entities/shop_order_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:asrar_app/features/shop/domain/entities/product_entities.dart';

import 'package:asrar_app/core/data/failure.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;
  ShopRepositoryImpl({required this.networkInfo});
  @override
  Future<Either<Failure, List<ProductEntities>>> getShopProducts() async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductEntities> productsList = [];
        final products = await firestore.collection(FireBaseConstants.products).get();
        for (var doc in products.docs) productsList.add(ProductEntities.fromMap(doc.data()));
        return Right(productsList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }

  @override
  Future<Either<Failure, Unit>> addShopOrder(ShopOrderEntities shopOrder) async {
    try {
      await firestore
          .collection(FireBaseConstants.shopOrders)
          .doc(shopOrder.shopOrderId.toString())
          .set(shopOrder.toMap());
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<ShopOrderEntities>>> getShopOrder(String userEmail) async {
    if (await networkInfo.isConnected) {
      try {
        List<ShopOrderEntities> shopOrderList = [];
        final shopOrders = await firestore.collection(FireBaseConstants.shopOrders).get();
        for (var doc in shopOrders.docs) {
          if (doc["email"] == userEmail) shopOrderList.add(ShopOrderEntities.fromMap(doc.data()));
        }
        shopOrderList.sort((a, b) => b.shopOrderId.compareTo(a.shopOrderId));
        return Right(shopOrderList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
  }

  @override
  Future<Either<Failure, Unit>> cancelShopOrder(ShopOrderEntities shopOrder) async {
    try {
      await firestore
          .collection(FireBaseConstants.shopOrders)
          .doc(shopOrder.shopOrderId.toString())
          .update({"orderStatus": OrderStatus.canceled.name});
      return const Right(unit);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
