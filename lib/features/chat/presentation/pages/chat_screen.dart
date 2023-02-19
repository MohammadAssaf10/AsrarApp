import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../functions/functions.dart';
import '../widgets/chat_bottom_widget.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
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
                        MessageWidget(
                          message: state.messagesList[index],
                          isMine: isMine,
                          isPreviousFromTheSameSender:
                              isPreviousFromTheSameSender(state.messagesList, index),
                        ),
                        if (isMine) SizedBox(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ChatBottom(onSended: () {
            _scrollController.animateTo(_scrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
          }),
        ],
      ),
    );
  }
}
