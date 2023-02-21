import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../domain/entities/message.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import 'chat_text_field.dart';

class ChatBottom extends StatelessWidget {
  ChatBottom({super.key, this.onSended});

  final Function? onSended;
  late final Sender sender;

  @override
  Widget build(BuildContext context) {
    var authUser = BlocProvider.of<AuthenticationBloc>(context).state.user!;
    sender = Sender(name: authUser.name, id: authUser.id, email: authUser.email);
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: AppSize.s10.w, top: AppSize.s10.w, right: AppSize.s10.w, bottom: AppSize.s15.h),
        child: Row(
          children: [
            Recorder(onSended: onSended),
            ImageButton(onSended: onSended, sender: sender),
            Expanded(
                child: ChatTextField(
              onSended: onSended,
            )),
            OptionButton(onSended: onSended)
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.onSended,
  }) : super(key: key);

  final Function? onSended;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          onTap: () async {
            onSended;
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: () {}, child: Text("انسحاب")),
                    TextButton(onPressed: () {}, child: Text("")),
                  ],
                ),
              ),
            );
          },
          child: Icon(
            Icons.more_vert,
            color: ColorManager.primary,
          )),
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.onSended,
    required this.sender,
  }) : super(key: key);

  final Function? onSended;
  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          onTap: () async {
            onSended;
            XFile? image = await selectFile(context);
            if (image != null) {
              BlocProvider.of<ChatBloc>(context)
                  .add(ImageMessageSent(image, ImageMessage.create(sender)));
            }
          },
          child: Icon(
            Icons.camera_alt,
            color: ColorManager.primary,
          )),
    );
  }
}

class Recorder extends StatelessWidget {
  Recorder({
    Key? key,
    required this.onSended,
  }) : super(key: key);

  final Function? onSended;
  final recorder = FlutterSoundRecorder();

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
