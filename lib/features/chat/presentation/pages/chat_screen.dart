import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/chat_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.messagesList.length,
            itemBuilder: (context, index) {
              return Text(state.messagesList[index].content);
            },
          );
        },
      ),
    );
  }
}
