import 'package:flutter/material.dart';

import '../../../../../config/assets_manager.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الدفع"),
      ),
      body: Center(
        child: Image.asset("$imagePath/pay.png"),
      ),
    );
  }
}
