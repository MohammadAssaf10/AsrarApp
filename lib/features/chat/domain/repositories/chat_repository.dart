import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<List<Message>>>> startChatStream();
  Future<Either<Failure, void>> sendMessage(TextMessage message);
}
