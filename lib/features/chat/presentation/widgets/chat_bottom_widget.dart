import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';
import 'chat_text_field.dart';

class ChatBottom extends StatelessWidget {
  const ChatBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: AppSize.s10.w, top: AppSize.s10.w, right: AppSize.s10.w, bottom: AppSize.s15.h),
        child: Row(
          children: [
            Expanded(child: ChatTextField()),
          ],
        ),
      ),
    );
  }
}