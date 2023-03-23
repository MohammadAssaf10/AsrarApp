import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/strings_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../chat/presentation/blocs/support_chat/support_chat_bloc.dart';
import '../../../../chat/presentation/functions/functions.dart';
import '../../../../chat/presentation/widgets/buttons/support_chat_bottom.dart';
import '../../../../chat/presentation/widgets/messages/message_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authState.status == AuthStatus.loggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.support.tr(context)),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<SupportChatBloc, SupportChatState>(
                listener: (context, state) {
                  if (state.fileUploadingStatus == Status.loading) {
                    showCustomDialog(context);
                  } else if (state.fileUploadingStatus == Status.success) {
                    dismissDialog(context);
                  } else if (state.fileUploadingStatus == Status.failed) {
                    showCustomDialog(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: state.messagesList.length,
                    itemBuilder: (context, index) {
                      var message = state.messagesList[index];
                      var isMine = message.isMine(
                          BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .user!
                              .id);

                      return Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!isMine) const SizedBox(),
                          MessageWidget(
                            message: state.messagesList[index],
                            isMine: isMine,
                            isPreviousFromTheSameSender:
                                isPreviousFromTheSameSender(
                                    state.messagesList, index),
                          ),
                          if (isMine) const SizedBox(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SupportChatBottom(onSended: () {
              scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            }),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
