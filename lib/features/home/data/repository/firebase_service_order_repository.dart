import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/service_order.dart';
import '../../domain/repository/service_order_repository.dart';

class FirebaseServiceOrderRepository extends ServiceOrderRepository {
  final FirebaseFirestore _firestore;
  final NetworkInfo _networkInfo;

  FirebaseServiceOrderRepository(
    this._firestore,
    this._networkInfo,
  );

  Future<int> getLastId() async {
    int id = 0;

    final data = await _firestore.collection(FireBaseConstants.serviceOrder).get();

    for (var doc in data.docs) {
      if (doc['id'] > id) id = doc['id'];
    }

    return id;
  }

  @override
  Future<Either<Failure, void>> addOrder(ServiceOrder serviceOrder) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      serviceOrder = serviceOrder.copyWith(id: (await getLastId()) + 1);

      _firestore
          .collection(FireBaseConstants.serviceOrder)
          .doc(serviceOrder.id.toString())
          .set(serviceOrder.toMap());

      return Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(ServiceOrder serviceOrder) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }
    try {
      await _firestore
          .collection(FireBaseConstants.serviceOrder)
          .doc(serviceOrder.id.toString())
          .update({"status": OrderStatus.canceled.name});
      return Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<ServiceOrder>>> getUserOrder(User user) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      List<ServiceOrder> servicesOrderList = [];

      final servicesOrderSnapShot =
          await _firestore.collection(FireBaseConstants.serviceOrder).get();
      for (var doc in servicesOrderSnapShot.docs) {
        var serviceOrder = ServiceOrder.fromMap(doc.data());

        if (user.id == serviceOrder.user.id) servicesOrderList.add(serviceOrder);
      }
      return Right(servicesOrderList);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
