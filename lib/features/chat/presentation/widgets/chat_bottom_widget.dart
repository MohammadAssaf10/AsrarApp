import 'package:asrar_app/core/app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/values_manager.dart';
import 'chat_text_field.dart';

class ChatBottom extends StatelessWidget {
  const ChatBottom({super.key, this.onSended});

  final Function? onSended;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: AppSize.s10.w, top: AppSize.s10.w, right: AppSize.s10.w, bottom: AppSize.s15.h),
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  XFile? image = await selectFile(context);
                  if (image != null) {
                    
                  }
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: ColorManager.primary,
                )),
            Expanded(
                child: ChatTextField(
              onSended: onSended,
            )),
          ],
        ),
      ),
    );
  }
}
