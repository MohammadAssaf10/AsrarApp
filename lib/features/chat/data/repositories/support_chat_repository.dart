import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../../core/data/exception_handler.dart';
import '../../../../core/data/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';

class SupportChatRepository extends ChatRepository {
  // ignore: unused_field
  final FirebaseFirestore _firestore;
  final NetworkInfo _networkInfo;
  final User user;
  final DocumentReference supportChatReference;

  SupportChatRepository(
      this._firestore,
      this._networkInfo,
      this.user,
      ) : supportChatReference =
  _firestore.collection(FireBaseConstants.supportChat).doc(user.id);

  @override
  Future<Either<Failure, void>> sendMessage(Message message) async {
    if (!await _networkInfo.isConnected) {
      return Left(DataSourceExceptions.noInternetConnections.getFailure());
    }

    try {
      await supportChatReference.collection(FireBaseConstants.supportChat).add(message.toMap());

      return const Right(null);
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
      return Right(supportChatReference.collection(FireBaseConstants.supportChat).snapshots().map(
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

  @override
  Future<Either<Failure, String>> uploadImage(XFile image) async {
    try {
      var file = await uploadFile(
          '${FireBaseConstants.supportChat}/${user.id}/images/${image.name}', image);
      print(file.url);
      return Right(file.url);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, String>> uploadVoice(XFile voice)  async{
    try {
      var file = await uploadFile(
          '${FireBaseConstants.supportChat}/${user.id}/voices/${voice.name}', voice);
      print(file.url);
      return Right(file.url);
    } catch (e) {
      return Left(ExceptionHandler.handle(e).failure);
    }
  }
}
