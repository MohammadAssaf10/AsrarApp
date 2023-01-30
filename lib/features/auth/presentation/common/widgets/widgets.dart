import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../config/app_localizations.dart';
import '../functions.dart';

class TextFrom extends StatelessWidget {
  const TextFrom({
    Key? key,
    this.validator,
    required this.icon,
    required this.label,
    this.onChange,
    this.keyboardType,
    this.controller,
    this.onFieldSubmitted, this.onTap,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final IconData icon;
  final String label;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChange,
      style: TextStyle(fontSize: AppSize.s16.sp),
      decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 14.sp),
          label: Row(
            children: [
              Icon(
                icon,
                color: ColorManager.grey,
              ),
              Text(
                label,
                style: TextStyle(
                    color: ColorManager.grey, fontSize: AppSize.s16.sp),
              ),
            ],
          )),
    );
  }
}

class FullElevatedButton extends StatelessWidget {
  const FullElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s50,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}

class AuthSwitcher extends StatefulWidget {
  AuthSwitcher({required this.onChange, super.key});

  @override
  State<AuthSwitcher> createState() => _AuthSwitcherState();

  final Function(bool) onChange;
}

class _AuthSwitcherState extends State<AuthSwitcher> {
  bool _login = true;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: roundedBorder(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _login = true;
                  });
                  widget.onChange(_login);
                },
                child: Card(
                  shape: roundedBorder(),
                  color: _login ? ColorManager.primary : null,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Text(
                      AppStrings.signIn.tr(context),
                      style:
                          TextStyle(color: _login ? ColorManager.white : null),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _login = false;
                  });
                  widget.onChange(_login);
                },
                child: Card(
                  shape: roundedBorder(),
                  color: _login ? null : ColorManager.primary,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Text(
                      AppStrings.signUp.tr(context),
                      style:
                          TextStyle(color: _login ? null : ColorManager.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
