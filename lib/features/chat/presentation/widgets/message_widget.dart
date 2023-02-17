import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../domain/entities/message.dart';
import 'text_message_widget.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget({super.key, required this.message, required this.isMine});

  final Message message;
   final bool isMine;

  @override
  Widget build(BuildContext context) {
    if (message is TextMessage)
      return TextMessageWidget(
        message: message as TextMessage,
        isMine: isMine,
      );
    return Container();
  }
}
