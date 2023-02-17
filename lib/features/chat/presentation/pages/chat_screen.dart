import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../widgets/chat_bottom_widget.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    var message = state.messagesList[index];
                    var isMine = message
                        .isMine(BlocProvider.of<AuthenticationBloc>(context).state.user!.email);

                    return Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isMine) SizedBox(),
                        MessageWidget(message: state.messagesList[index], isMine: isMine),
                        if (isMine) SizedBox(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ChatBottom(),
        ],
      ),
    );
  }
}
