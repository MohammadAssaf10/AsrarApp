import 'package:flutter/material.dart';

import '../../../../../config/assets_manager.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدردشة"),
      ),
      body: Center(
        child: Image.asset("$imagePath/chat.png"),
      ),
    );
  }
}
