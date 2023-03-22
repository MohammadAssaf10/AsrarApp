import 'package:asrar_app/features/chat/presentation/widgets/buttons/support_image_button.dart';
import 'package:asrar_app/features/chat/presentation/widgets/buttons/support_recorder_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/values_manager.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../domain/entities/message.dart';
import '../support_chat_text.dart';

class SupportChatBottom extends StatefulWidget {
  const SupportChatBottom({super.key, this.onSended, /*required this.serviceOrder*/});

  final Function? onSended;
  // final ServiceOrder serviceOrder;

  @override
  State<SupportChatBottom> createState() => _ChatBottomState();
}

class _ChatBottomState extends State<SupportChatBottom> {
  late final Sender sender;
  bool isRecordActive = false;

  @override
  void initState() {
    var authUser = BlocProvider.of<AuthenticationBloc>(context).state.user!;
    sender = Sender(name: authUser.name, id: authUser.id, email: authUser.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: AppSize.s10.w, top: AppSize.s10.w, right: AppSize.s10.w, bottom: AppSize.s15.h),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SupportRecorderButton(
              recordActivated: (processing) {
                setState(() {
                  isRecordActive = processing;
                });
              },
              onSended: widget.onSended,
              sender: sender,
            ),
            if (!isRecordActive) SupportImageButton(onSended: widget.onSended, sender: sender),
            if (!isRecordActive)
              Expanded(
                  child: SupportChatTextField(
                    onSended: widget.onSended,
                  )),
            // if (!isRecordActive)
            //   OptionButton(
            //     onSended: widget.onSended,
            //     serviceOrder: widget.serviceOrder,
            //   )
          ],
        ),
      ),
    );
  }
}
