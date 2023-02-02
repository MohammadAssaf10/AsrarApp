import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
