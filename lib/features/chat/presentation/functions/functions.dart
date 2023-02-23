import 'package:flutter/animation.dart';

import '../../../../config/color_manager.dart';
import '../../domain/entities/message.dart';

Color getMessageColor(bool v) => v ? ColorManager.lightGreen : ColorManager.white;

bool isPreviousFromTheSameSender(List<Message> message, int index) {
  if (index == message.length - 1) {
    return false;
  } else if (message[index].details.sender == message[index + 1].details.sender) {
    return true;
  }
  return false;
}
