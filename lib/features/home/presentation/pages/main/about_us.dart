import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUs.tr(context),
        ),
      ),
      body: Center(
        child: Text(
          "\"أسرار\" هو تطبيق للخدمات الإلكترونية يسمح للمستخدمين بتبادل الأسرار بشكل آمن.\n\n تطبيق أسرار للخدمات الإلكترونية يساعد على التسجيل وإعلان الوظائف والجامعات والدورات المجانية وإلغاء الخدمات والمطالبة وأسترجاع البيانات الإلكترونيةبكل مصداقية ويحفظ حقوق المستخدمين من المعلومات والخدمات المقدمة ودفع الأموال في مصادر غير موثوقة فقمنا ببتكار وتصميم التطبيق لخدمة الكبار والصغار والشباب والفتيات.",
          style: getAlmaraiRegularStyle(
            fontSize: AppSize.s22.sp,
            color: ColorManager.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
