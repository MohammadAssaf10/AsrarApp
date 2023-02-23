import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/color_manager.dart';
import '../../../domain/entities/message.dart';

class RecorderButton extends StatefulWidget {
  RecorderButton({
    Key? key,
    required this.onSended,
    required this.sender,
    required this.recordActivated,
  }) : super(key: key);

  final Function? onSended;
  final Function(bool) recordActivated;
  final Sender sender;

  @override
  State<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends State<RecorderButton> {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  bool recordProcessing = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    print(status);
    print(status);
    print(status);

    recorder.openRecorder();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async {
          widget.onSended;
          if (recorder.isRecording) {
            await recorder.stopRecorder();
          } else {
            await recorder.startRecorder(toFile: 're');
          }
          setState(() {});
          widget.recordActivated(recorder.isRecording);
        },
        child: Icon(
          recorder.isRecording ? Icons.stop : Icons.mic,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
