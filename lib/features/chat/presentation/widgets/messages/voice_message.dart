import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/message.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VoiceMessageWidget extends StatefulWidget {
  const VoiceMessageWidget({super.key, required this.message});

  final VoiceMessage message;

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  StreamSubscription? onPlayerStateChanged;
  StreamSubscription? onDurationChanged;
  StreamSubscription? onPositionChanged;

  @override
  void initState() {
    super.initState();

    onPlayerStateChanged = audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    onDurationChanged = audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    onPositionChanged = audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    onPlayerStateChanged?.cancel();
    onDurationChanged?.cancel();
    onPositionChanged?.cancel();

    super.dispose();
  }

  

  String getTime(Duration duration) {
    String result = '';

    var minute = (duration.inMinutes % 60).truncate();
    result += minute < 10 ? '0$minute:' : '$minute';

    var sec = (duration.inSeconds % 60).truncate();
    result += sec < 10 ? '0$sec' : '$sec';

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (isPlaying) {
              audioPlayer.pause();
            } else {
              audioPlayer.play(UrlSource(widget.message.voiceUrl));
            }
          },
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 40.r,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
              },
            ),
            Text(getTime(duration))
          ],
        ),
      ],
    );
  }
}
