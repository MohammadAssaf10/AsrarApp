import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../domain/entities/message.dart';
import '../../functions/functions.dart';
import 'image_message_widget.dart';
import 'text_message_widget.dart';

class MessageWidget extends StatelessWidget {
  MessageWidget(
      {super.key,
      required this.message,
      required this.isMine,
      required this.isPreviousFromTheSameSender})
      : time =
            '${message.details.createdAt.toDate().hour % 12}:${message.details.createdAt.toDate().minute < 10 ? '0${message.details.createdAt.toDate().minute}' : message.details.createdAt.toDate().minute}';

  final Message message;
  final bool isMine;
  final bool isPreviousFromTheSameSender;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSize.s8.h,
        isPreviousFromTheSameSender ? AppSize.s0 : AppSize.s8.h,
        AppSize.s8.h,
        AppSize.s8.h,
      ),
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMine & !isPreviousFromTheSameSender)
            Text(
              message.details.sender.name,
              style: const TextStyle(color: ColorManager.veryDarkGrey),
            ),
          Card(
            margin: const EdgeInsets.only(),
            color: getMessageColor(isMine),
            child: MessageTypeDirector(message: message),
          ),
          Text(
            time,
            style: const TextStyle(color: ColorManager.veryDarkGrey),
          ),
        ],
      ),
    );
  }
}

class MessageTypeDirector extends StatelessWidget {
  const MessageTypeDirector({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    if (message is TextMessage) {
      return TextMessageWidget(
        message: message as TextMessage,
      );
    } else if (message is ImageMessage) {
      return ImageMessageWidget(
        message: message as ImageMessage,
      );
    } else {
      return Container();
    }
  }
}
