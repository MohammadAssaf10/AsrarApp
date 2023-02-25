import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app/constants.dart';
import '../../../../../core/app/di.dart';
import '../../../../home/domain/entities/service_order.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository = instance();
  StreamSubscription? _messageStream;

  ChatBloc() : super(ChatState.init()) {
    on<ChatStarted>((event, emit) async {
      await (await _chatRepository.startChatStream()).fold(
        (l) {
          print(l);
        },
        (r) async {
          _messageStream = r.listen((event) {
            add(_MessageReserved(messageList: event));
          });
        },
      );
    });

    on<_MessageReserved>(
      (event, emit) {
        final list = event.messageList;
        list.sort((a, b) => b.details.createdAt.compareTo(a.details.createdAt));
        emit(state.copyWith(messagesList: list));
      },
    );

    on<TextMessageSent>(
      (event, emit) async {
        (await _chatRepository.sendMessage(event.message)).fold(
          (l) {
            emit(state.copyWith(status: Status.failed, message: l.message));
          },
          (r) {},
        );
      },
    );

    on<ImageMessageSent>(
      (event, emit) async {
        emit(state.copyWith(fileUploadingStatus: Status.loading));
        await (await _chatRepository.uploadImage(event.image)).fold(
          (l) {
            emit(state.copyWith(fileUploadingStatus: Status.failed, message: l.message));
          },
          (r) async {
            emit(state.copyWith(fileUploadingStatus: Status.success));

            var imageMessage = event.message.copyWith(imageUrl: r);
            (await _chatRepository.sendMessage(imageMessage)).fold(
              (l) {
                emit(state.copyWith(status: Status.failed, message: l.message));
              },
              (r) {},
            );
          },
        );
      },
    );

    on<ChatEnded>((event, emit) {
      _messageStream?.cancel();
    });
  }

  @override
  Future<void> close() {
    _messageStream?.cancel();
    return super.close();
  }
}
