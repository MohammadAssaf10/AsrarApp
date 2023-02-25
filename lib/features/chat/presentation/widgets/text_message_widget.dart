import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';
import '../../domain/entities/message.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({super.key, required this.message});

  final TextMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message.content,
        style: const TextStyle(color: ColorManager.veryDarkGrey),
      ),
    );
  }
}
