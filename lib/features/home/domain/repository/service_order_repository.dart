import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../auth/domain/entities/user.dart';
import '../entities/service_order.dart';

abstract class ServiceOrderRepository {
  Future<Either<Failure, List<ServiceOrder>>> getUserOrder(UserEntities user);
  Future<Either<Failure, void>> addOrder(ServiceOrder serviceOrder);
  Future<Either<Failure, void>> cancelOrder(ServiceOrder serviceOrder);
}
