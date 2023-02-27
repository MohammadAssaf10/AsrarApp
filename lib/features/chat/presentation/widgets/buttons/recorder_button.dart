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
  String patho = '';

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

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    print(status);

    recorder.openRecorder();

    Directory? appDir = await getExternalStorageDirectory();
    String jrecord = 'Audiorecords';
    String dato = "${DateTime.now().millisecondsSinceEpoch.toString()}.wav";
    Directory appDirec = Directory("${appDir!.path}/$jrecord/");
    if (await appDirec.exists()) {
      // playAudio.value = true;
      patho = "${appDirec.path}$dato";
      print("path for file $patho");
      // _recordingSession.openAudioSession();
      // await recorder.startRecorder(
      //   toFile: patho,
      //   codec: Codec.pcm16WAV,
      // );
      // _recordingSession.onProgress.listen((e) {
      //   var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //       isUtc: true);
      //   var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      //   timerText.value = timeText.substring(0, 8);
      // });
    } else {
      appDirec.create(recursive: true);
      patho = "${appDirec.path}$dato";
      print("path for file $patho");
      // _recordingSession.openAudioSession();
      // await recorder.startRecorder(
      //   toFile: patho,
      //   codec: Codec.pcm16WAV,
      // );

      // _recordingSession.onProgress.listen((e) {
      //   var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //       isUtc: true);
      //   var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      //   timerText.value = timeText.substring(0, 8);
      // });
    }
  }

  Future<String> startRecording() async {
    Directory? appDir = await getExternalStorageDirectory();
    String jrecord = 'Audiorecords';
    String dato = "${DateTime.now().millisecondsSinceEpoch.toString()}.wav";
    Directory appDirec = Directory("${appDir!.path}/$jrecord/");
    if (await appDirec.exists()) {
      // playAudio.value = true;
      String patho = "${appDirec.path}$dato";
      print("path for file11 $patho");
      // _recordingSession.openAudioSession();
      await recorder.startRecorder(
        toFile: patho,
        codec: Codec.pcm16WAV,
      );
      // _recordingSession.onProgress.listen((e) {
      //   var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //       isUtc: true);
      //   var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      //   timerText.value = timeText.substring(0, 8);
      // });
    } else {
      appDirec.create(recursive: true);
      String patho = "${appDirec.path}$dato";
      print("path for file22 $patho");
      // _recordingSession.openAudioSession();
      await recorder.startRecorder(
        toFile: patho,
        codec: Codec.pcm16WAV,
      );

      // _recordingSession.onProgress.listen((e) {
      //   var date = DateTime.fromMillisecondsSinceEpoch(e.duration.inMilliseconds,
      //       isUtc: true);
      //   var timeText = DateFormat('mm:ss:SS', 'en_GB').format(date);
      //   timerText.value = timeText.substring(0, 8);
      // });
    }
    return dato;
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
            var voice = XFile(patho);
            // ignore: use_build_context_synchronously
            BlocProvider.of<ChatBloc>(context)
                .add(VoiceMessageSent(voice, VoiceMessage.create(widget.sender)));
          } else {
            recorder.startRecorder(
              toFile: patho,
            );
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
