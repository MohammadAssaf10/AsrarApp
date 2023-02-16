import 'package:dartz/dartz.dart';

import '../../../../core/data/failure.dart';
import '../../../home/domain/entities/service_order.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<List<Message>>>> startChatStream(ServiceOrder serviceOrder);
  Future<Either<Failure, void>> sendMessage();
}
