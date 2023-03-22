import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../payment/data/repository/tap_payment_repository.dart';
import '../../domain/entities/product_entities.dart';
import '../../domain/entities/shop_order_entities.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../presentation/common/function.dart';

class ShopRepositoryImpl extends ShopRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final NetworkInfo networkInfo;

  ShopRepositoryImpl({required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductEntities>>> getShopProducts() async {
    if (await networkInfo.isConnected) {
      try {
        List<ProductEntities> productsList = [];
        final products =
            await firestore.collection(FireBaseConstants.products).get();
        for (var doc in products.docs) {
          productsList.add(ProductEntities.fromMap(doc.data()));
        }
        return Right(productsList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addShopOrder(
      ShopOrderEntities shopOrder) async {
    try {
      shopOrder = shopOrder.copyWith(shopOrderId: (await getLastId()) + 1);
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
  Future<Either<Failure, List<ShopOrderEntities>>> getShopOrder(
      String userId) async {
    if (await networkInfo.isConnected) {
      try {
        List<ShopOrderEntities> shopOrderList = [];
        final shopOrders =
            await firestore.collection(FireBaseConstants.shopOrders).get();
        for (var doc in shopOrders.docs) {
          if (doc["user"]["id"] == userId) {
            shopOrderList.add(ShopOrderEntities.fromMap(doc.data()));
          }
        }
        shopOrderList.sort((a, b) => b.shopOrderId.compareTo(a.shopOrderId));
        return Right(shopOrderList);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelShopOrder(
      ShopOrderEntities shopOrder) async {
    if (await networkInfo.isConnected) {
      try {
        return (await returnMoney(shopOrder.totalPrice, shopOrder.chargeId)).fold(
            (failure) {
          return Left(failure);
        }, (r) async {
          await firestore
              .collection(FireBaseConstants.shopOrders)
              .doc(shopOrder.shopOrderId.toString())
              .update({"orderStatus": OrderStatus.canceled.name});
          return const Right(unit);
        });
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }

  Future<Either<Failure, Unit>> returnMoney(int amount, String chargeId) async {
    if (await networkInfo.isConnected) {
      try {
        await TapPaymentService().refound(
            chargeId: chargeId,
            currency: 'SAR',
            reason: 'returned',
            amount: amount);
        return const Right(unit);
      } catch (e) {
        return Left(ExceptionHandler.handle(e).failure);
      }
    } else {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
  }
}
