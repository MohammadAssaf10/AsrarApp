import 'package:flutter/material.dart';

import '../../../../config/values_manager.dart';

class FullElevatedButton extends StatelessWidget {
  const FullElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s50,
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}