import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/values_manager.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../home/domain/entities/service_order.dart';
import '../../../domain/entities/message.dart';
import '../chat_text_field.dart';
import 'image_button.dart';
import 'option_button_widget.dart';
import 'recorder_button.dart';

class ChatBottom extends StatelessWidget {
  ChatBottom({super.key, this.onSended, required this.serviceOrder});

  final Function? onSended;
  late final Sender sender;
  final ServiceOrder serviceOrder;

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
          textDirection: TextDirection.ltr,
          children: [
            RecorderButton(
              onSended: onSended,
              sender: sender,
            ),
            ImageButton(onSended: onSended, sender: sender),
            Expanded(
                child: ChatTextField(
              onSended: onSended,
            )),
            OptionButton(
              onSended: onSended,
              serviceOrder: serviceOrder,
            )
          ],
        ),
      ),
    );
  }
}
