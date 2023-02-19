import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../../domain/entities/message.dart';
import '../functions/functions.dart';
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
              style: TextStyle(color: ColorManager.veryDarkGrey),
            ),
          Card(
            margin: EdgeInsets.only(),
            color: getMessageColor(isMine),
            child: TextMessageWidget(
              message: message as TextMessage,
            ),
          ),
          Text(
            time,
            style: TextStyle(color: ColorManager.veryDarkGrey),
          ),
        ],
      ),
    );
  }
}
