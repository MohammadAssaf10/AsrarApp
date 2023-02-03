import 'package:flutter/material.dart';

import '../../../../../config/color_manager.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: ColorManager.primary,
      ),
    );
  }
}
