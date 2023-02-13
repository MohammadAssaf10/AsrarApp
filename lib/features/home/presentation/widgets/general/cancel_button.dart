import 'package:flutter/material.dart';

import '../../../../../config/color_manager.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          onTap();
        },
        icon: Icon(
          Icons.delete,
          color: ColorManager.primary,
        ),
      ),
    );
  }
}