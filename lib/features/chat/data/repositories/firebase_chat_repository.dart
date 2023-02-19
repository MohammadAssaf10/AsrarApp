import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../home/domain/entities/service_order.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';

class FirebaseChatRepository extends ChatRepository {
  final FirebaseFirestore _firestore;
  final NetworkInfo _networkInfo;
  final ServiceOrder serviceOrder;
  final DocumentReference orderReference;

  FirebaseChatRepository(
    this._firestore,
    this._networkInfo,
    this.serviceOrder,
  ) : orderReference =
            _firestore.collection(FireBaseConstants.serviceOrder).doc(serviceOrder.id.toString());

  @override
  Future<Either<Failure, void>> sendMessage(TextMessage message) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      await orderReference.collection(FireBaseConstants.messages).add(message.toMap());

      return Right(null);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Stream<List<Message>>>> startChatStream() async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      return Right(orderReference.collection(FireBaseConstants.messages).snapshots().map(
        (event) {
          List<Message> list = [];
          for (var doc in event.docs) {
            list.add(Message.fromMap(doc.data()));
          }
          return list;
        },
      ));
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
