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

  FirebaseChatRepository(
    this._firestore,
    this._networkInfo,
  );
  @override
  Future<Either<Failure, void>> sendMessage() {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Stream<List<Message>>>> startChatStream(ServiceOrder serviceOrder) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      return Right(_firestore
          .collection(FireBaseConstants.serviceOrder)
          .doc(serviceOrder.id.toString())
          .collection(FireBaseConstants.messages)
          .snapshots()
          .map(
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
