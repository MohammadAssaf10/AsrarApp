import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    Key? key,
    this.labelText,
    this.hintText,
    required this.regExp,
    this.controller,
    required this.textInputType,
    this.horizontalContentPadding = 0,
    this.textAlign = TextAlign.start,
    this.onChanage,
    this.suffixIcon,
    this.validator,
    this.formKey,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final RegExp regExp;
  final TextEditingController? controller;
  final double horizontalContentPadding;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final Function(String)? onChanage;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: () {
          if (controller!.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller!.text.length - 1))) {
            controller!.selection = TextSelection.fromPosition(
                TextPosition(offset: controller!.text.length));
          }
        },
        onChanged: onChanage,
        validator: validator,
        controller: controller,
        textAlign: textAlign,
        keyboardType: textInputType,
        inputFormatters: [
          FilteringTextInputFormatter.allow(regExp),
        ],
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalContentPadding,
          ),
        ),
      ),
    );
  }
}
