import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.termsOfUse.tr(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s10.w,
          vertical: AppSize.s10.h,
        ),
        child: ListView(
          children: [
            Text(
              "1- الشروط والأحكام:",
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s20.sp,
                color: ColorManager.black,
              ),
            ),
            SizedBox(height: AppSize.s5.h),
            Text(
              "هنا تجدون الشروط والأحكام الأساسية الخاصة بتطبيق أسرار للخدمات الإلكترونية:\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "1/النسبة المئوية الخاصة بالتطبيق هي 20% على مقدمين الخدمة وهي قابلة للزيادة بشكل غير متزامن وحسب ضريبة القيمة المضافة.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "2/يجب على العميل الدفع للإجراءات المطلوبة الخاصة بالدفع والرسوم الخاصة بالتطبيق مقابل الخدمة المطلوبة.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "3/يجب على العميل الحفاظ على المعلومات الشخصية الخاصة به والاشخاص الذين يقدمون لهم الخدمة, وعدم مشاركتها مع أي طرف ثالث أو حفظها أو تسريب بيانات العملاء أو استخدامها لمصالح شخصية وفي حال التأكد من ذلك يحق للتطبيق اتخاذ الإجرات الرسمية أو ما تراه إدارة التطبيق فأن للتطبيق جميع المسؤولية لرفعه لجميع الجهات الأختصاص والمطالبة وعدم التعويض لأي جهة أخرى أو شخصية.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "4/يجب على العميل أو مقدم الخدمة الإبلاغ عن أي تغيير في المعلومات الشخصية الخاصة به, كما يجب الإبلاغ عن أي تغيير في البيانات الخاصة ك الاسم أو الجنسية أو الحساب البنكي أو غيرها من المعلومات.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "5/يجب على العميل الالتزام بجيمع القوانين واللوائح الصادرة عن التطبيق, والالتزام بجيمع الشروط والأحكام الخاصة بالشركة.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "6/يجب على العميل الالتزام بجيمع الشروط والأحكام الخاصة بالتطبيق أو استخدامها لمصالح شخصية",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            SizedBox(height: AppSize.s10.h),
            Text(
              "2-سياسة الخصوصية:",
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s20.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "سياية الخصوصية لتطبيق أسرار هي كالتالي:",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "1/نحن نجمع ونخزن المعلومات الشخصية الخاصة بالمستخدمين, مثل الاسم وعنوان البريد الإلكتروني ورقم الجوال, فقط لغايات التعامل مع المستخدمين وللاطلاع على الشكاوي والاقتراحات.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "2/نحن لا نشارك المعلومات الشخصية الخاصة بالمستخدمين, مع الجهات الخاجية, إلا إذا كان ذلك مطلوب بموجب القانون.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "3/نحن نضع جهداً كبيراً لحماية المعلومات الشخصية الخاصة بالمستخدمين, ولكن نطلع المستخدمين على الأخطاء المحتملة التي قد تحدث في الشبكة الإلترونية.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "4/نحن نحتفظ بالحق في تغيير سياسة الخصوصية في أي وقت, وسنشارك التغييرات الجديدة مع المستخدمين عبلا التطبيق.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "5/المستخدمين يحق لهم الوصول للمعلومات الشخصية الخاصة بهم وتعديلها في أي وقت, ويحق لهم الطلب والحذف المعلومات الشخصية الخاصة بهم.\n",
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
            Text(
              "ملاحظة فالأهيمة: هذه الشروط والاحكام والسياسات قابلة للتعديل في أي وقت.",
              style: getAlmaraiBoldStyle(
                fontSize: AppSize.s18.sp,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
