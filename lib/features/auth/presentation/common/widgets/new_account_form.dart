import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/extensions.dart';
import '../../../../../core/app/functions.dart';
import '../../../data/models/requests.dart';
import '../../bloc/authentication_bloc.dart';
import 'widgets.dart';

class NewAccountForm extends StatefulWidget {
  const NewAccountForm({super.key});

  @override
  State<NewAccountForm> createState() => _NewAccountFormState();
}

class _NewAccountFormState extends State<NewAccountForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String phoneNumber = '';
  String countryCode = '963';

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _nameTextEditingController =
      TextEditingController();

  bool validateEmail = false;

  bool validatePassword = false;

  bool validateUserName = false;

  bool validatePhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
      child: Column(
        children: [
          SizedBox(
            height: AppSize.s40.h,
          ),
          Form(
            key: _key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFrom(
                  controller: _emailTextEditingController,
                  icon: Icons.email_outlined,
                  label: AppStrings.email.tr(context),
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    setState(() {
                      validateEmail = true;
                    });
                  },
                  validator: (v) {
                    if (validateEmail) {
                      return emailValidator(v, context);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  controller: _nameTextEditingController,
                  icon: Icons.person_outline,
                  label: AppStrings.userName.tr(context),
                  onTap: () {
                    setState(() {
                      validateUserName = true;
                    });
                  },
                  validator: (val) {
                    if (validateUserName) {
                      return nameValidator(val, context);
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                IntlPhoneField(
                  onTap: () {
                    setState(() {
                      validatePhoneNumber = true;
                    });
                  },
                  validator: (val) {
                    if (validatePhoneNumber) {
                      return mobileNumberValidator(val.toString(), context);
                    }
                    return null;
                  },
                  showCursor: false,
                  invalidNumberMessage:
                      AppStrings.mobileNumberFormatNotCorrect.tr(context),
                  // ignore: deprecated_member_use
                  searchText: AppStrings.searchCountry.tr(context),
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: ColorManager.primary,
                  ),
                  decoration: InputDecoration(
                    labelText: AppStrings.mobileNumber.tr(context),
                    labelStyle:
                        Theme.of(context).inputDecorationTheme.labelStyle,
                  ),
                  initialCountryCode: 'SY',
                  onChanged: (phone) {
                    countryCode = phone.countryCode;
                    phoneNumber = phone.number;
                  },
                ),
                SizedBox(height: AppSize.s15.h),
                TextFrom(
                  controller: _passwordTextEditingController,
                  icon: Icons.lock_outline,
                  label: AppStrings.password.tr(context),
                  onTap: () {
                    setState(() {
                      validatePassword = true;
                    });
                  },
                  validator: (v) {
                    if (validatePassword) {
                      if (v.nullOrEmpty() || v!.length < 6) {
                        return AppStrings.passwordShouldAtLeast6Character
                            .tr(context);
                      }
                    }
                    return null;
                  },
                ),
                TextButton(
                  child: Text(
                    AppStrings.forgetYourPassword.tr(context),
                    style: const TextStyle(color: ColorManager.grey),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.passwordReset);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s50.h,
          ),
          FullElevatedButton(
            onPressed: () async {
              setState(() {
                validateEmail = true;
                validatePassword = true;
                validateUserName = true;
              });
              if (_key.currentState!.validate()) {
                if (phoneNumber[0] == '0') {
                  phoneNumber = phoneNumber.replaceFirst('0', '');
                }
                phoneNumber = countryCode + phoneNumber;
                BlocProvider.of<AuthenticationBloc>(context).add(
                  RegisterButtonPressed(
                    RegisterRequest(
                      id: '',
                      tapId: '',
                      name: _nameTextEditingController.text,
                      email: _emailTextEditingController.text,
                      password: _passwordTextEditingController.text,
                      phoneNumber: phoneNumber.replaceAll('+', ''),
                      userTokenList: [],
                      imageURL: "",
                      imageName: "",
                    ),
                  ),
                );
              }
            },
            text: AppStrings.registerNewAccount.tr(context),
          )
        ],
      ),
    );
  }
}
