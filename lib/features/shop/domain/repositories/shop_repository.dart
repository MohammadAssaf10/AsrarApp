import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/product_entities.dart';
import '../entities/shop_order_entities.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<ProductEntities>>> getShopProducts();
  Future<Either<Failure, Unit>> addShopOrder(ShopOrderEntities shopOrder);
  Future<Either<Failure, Unit>> cancelShopOrder(ShopOrderEntities shopOrder);
  Future<Either<Failure, List<ShopOrderEntities>>> getShopOrder(
      String userId);
}
