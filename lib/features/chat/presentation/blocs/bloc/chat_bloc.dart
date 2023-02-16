import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/app/di.dart';
import '../../../../home/domain/entities/service_order.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository _chatRepository = instance();
  StreamSubscription? _messageStream;

  ChatBloc() : super(ChatState.init()) {
    on<ChatStarted>((event, emit) async {
      await (await _chatRepository.startChatStream(event.serviceOrder)).fold(
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
        emit(state.copyWith(messagesList: event.messageList));
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
