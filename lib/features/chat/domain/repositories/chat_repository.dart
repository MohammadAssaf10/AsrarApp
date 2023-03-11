import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/failure.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<List<Message>>>> startChatStream();
  Future<Either<Failure, void>> sendMessage(Message message);
  Future<Either<Failure, String>> uploadImage(XFile image);
  Future<Either<Failure, String>> uploadVoice(XFile voice);
}
