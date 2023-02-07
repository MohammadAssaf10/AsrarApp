import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    Key? key,
    this.labelText,
    this.hintText,
    required this.regExp,
    this.controller,
    required this.height,
    this.horizontalContentPadding = 0,
    this.textAlign=TextAlign.start,
  }) : super(key: key);
  final String? labelText;
  final String? hintText;
  final RegExp regExp;
  final TextEditingController? controller;
  final double height;
  final double horizontalContentPadding;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        textAlign: textAlign,
        inputFormatters: [
          FilteringTextInputFormatter.allow(regExp),
        ],
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalContentPadding,
            )),
      ),
    );
  }
}
