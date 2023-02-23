import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../widgets/general/home_button_widgets.dart';
import '../../widgets/general/input_form_field.dart';
import '../../../../../core/app/extensions.dart';

class YourAccountScreen extends StatelessWidget {
  const YourAccountScreen(this.user, {super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: user.email);
    final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: user.name);
    final GlobalKey<FormState> nameKey = GlobalKey<FormState>();
    final TextEditingController phoneController =
        TextEditingController(text: user.phoneNumber);
    final GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
    String phoneNumber = '';
    String countryCode = '';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.yourAccount.tr(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputFormField(
                formKey: emailKey,
                controller: emailController,
                labelText: AppStrings.email.tr(context),
                regExp: getTextWithNumberInputFormat(),
                textInputType: TextInputType.emailAddress,
                horizontalContentPadding: AppSize.s12.w,
                validator: (String? email) {
                  if (email.nullOrEmpty()) {
                    return AppStrings.pleaseEnterEmail.tr(context);
                  }
                  if (!isEmailFormatCorrect(email!)) {
                    return AppStrings.emailFormatNotCorrect.tr(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.s20.h),
              InputFormField(
                formKey: nameKey,
                controller: nameController,
                labelText: AppStrings.userName.tr(context),
                regExp: getAllKeyboradInputFormat(),
                textInputType: TextInputType.text,
                horizontalContentPadding: AppSize.s12.w,
                validator: (String? name) {
                  if (name.nullOrEmpty()) {
                    return AppStrings.pleaseEnterUserName.tr(context);
                  }
                  if (name!.length < 3) {
                    return AppStrings.userNameShouldAtLeast3Caracter
                        .tr(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.s20.h),
              Form(
                key: phoneKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: IntlPhoneField(
                  controller: phoneController,
                  invalidNumberMessage:
                      AppStrings.mobileNumberFormatNotCorrect.tr(context),
                  // ignore: deprecated_member_use
                  searchText: AppStrings.searchCountry.tr(context),
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorManager.primary,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    countryCode = phone.countryCode;
                    phoneNumber = phone.number;
                  },
                ),
              ),
              SizedBox(height: AppSize.s30.h),
              OptionButton(
                onTap: () {
                  if (emailKey.currentState!.validate() &&
                      nameKey.currentState!.validate() &&
                      phoneKey.currentState!.validate()) {
                    print("Done");
                  }
                },
                title: AppStrings.save.tr(context),
                height: AppSize.s40.h,
                width: AppSize.s150.w,
                fontSize: AppSize.s20.sp,
              ),
            ],
          ),
        ));
  }
}
