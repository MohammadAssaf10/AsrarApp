import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';
import '../../domain/entities/message.dart';
import '../functions/functions.dart';

class TextMessageWidget extends StatelessWidget {
  TextMessageWidget({super.key, required this.message, required this.isMine})
      : time =
            '${message.details.createdAt.toDate().hour % 12}:${message.details.createdAt.toDate().minute < 10 ? '0${message.details.createdAt.toDate().minute}' : message.details.createdAt.toDate().minute}';

  final TextMessage message;
  final bool isMine;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMine) Text(message.details.sender.name),
          Card(
            margin: EdgeInsets.only(),
            color: getMessageColor(isMine),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message.content,
                style: TextStyle(color: ColorManager.veryDarkGrey),
              ),
            ),
          ),
          Text(time),
        ],
      ),
    );
  }
}
