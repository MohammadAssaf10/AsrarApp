import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/color_manager.dart';
import '../../../domain/entities/message.dart';
import '../../blocs/chat_bloc/chat_bloc.dart';

class RecorderButton extends StatefulWidget {
  const RecorderButton({
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
  String voiceFilePath = '';
  String timerText = '00:00:00';
  late StreamController recorderStreamController;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.closeRecorder();
  }

  // done
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    print(status);

    recorder.openRecorder();
  }

  Future<String> startRecording() async {
    Directory? appDir = await getExternalStorageDirectory();
    String date = "${DateTime.now().millisecondsSinceEpoch.toString()}.wav";
    Directory appDirec = Directory("${appDir!.path}/audio records/");

    appDirec.create(recursive: true);

    String patho = "${appDirec.path}$date";
    await recorder.startRecorder(
      toFile: patho,
      codec: Codec.pcm16WAV,
    );

    //TODO: delete this shit (dosent add envent at all)
    // recorderSubscription = recorder.onProgress!.listen((e) {
    //   var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds, isUtc: true);
    //   var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
    //   setState(() {
    //     timerText = timeText.substring(0, 8);
    //   });

    //   print('');
    //   print('1');
    //   print('2');
    //   print(timerText);
    //   print('2');
    //   print('1');
    //   print('');
    // });

    recorderStreamController = StreamController();
    recorderStreamController.addStream(Stream<String>.periodic(
      const Duration(seconds: 1),
      (computationCount) {
        String duration = '';

        int minuteDuration = (computationCount / 60).truncate();
        duration += minuteDuration < 10 ? '0$minuteDuration:' : '$minuteDuration:';

        var secDuration = computationCount % 60;
        duration += secDuration < 10 ? '0$secDuration' : '$secDuration';

        print(duration);
        print(computationCount);
        return duration;
      },
    ));

    return patho;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!recordProcessing)
            InkWell(
              onTap: () async {
                widget.onSended;

                recordProcessing = true;
                voiceFilePath = await startRecording();

                widget.recordActivated(recordProcessing);
                setState(() {});
              },
              child: const Icon(
                Icons.mic,
                color: ColorManager.primary,
              ),
            ),
          if (recordProcessing)
            InkWell(
              onTap: () async {
                recordProcessing = false;
                widget.recordActivated(recordProcessing);

                await recorder.stopRecorder();
                recorderStreamController.close();
                var voice = XFile(voiceFilePath);
                // ignore: use_build_context_synchronously
                BlocProvider.of<ChatBloc>(context)
                    .add(VoiceMessageSent(voice, VoiceMessage.create(widget.sender)));
              },
              child: const Icon(
                Icons.stop,
                color: ColorManager.primary,
              ),
            ),
          if (recordProcessing)
            StreamBuilder(
              stream: recorderStreamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else {
                  return Container();
                }
              },
            ),
          if (recordProcessing)
            InkWell(
              onTap: () async {
                recordProcessing = false;
                widget.recordActivated(recordProcessing);

                await recorder.stopRecorder();
                recorderStreamController.close();
              },
              child: const Icon(
                Icons.delete,
                color: ColorManager.primary,
              ),
            ),
        ],
      ),
    );
  }
}
