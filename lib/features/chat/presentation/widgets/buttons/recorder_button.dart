import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

import '../../../../../config/color_manager.dart';
import '../../../domain/entities/message.dart';

class RecorderButton extends StatelessWidget {
  RecorderButton({
    Key? key,
    required this.onSended,
    required this.sender,
  }) : super(key: key);

  final Function? onSended;
  final Sender sender;
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async {
          onSended;
          if (recorder.isRecording) {
            await recorder.stopRecorder();
          } else {
            await recorder.startRecorder();
          }
        },
        child: Icon(
          Icons.mic,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
