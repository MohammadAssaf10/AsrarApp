import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/values_manager.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    TextEditingController? controller,
    String? label,
    String? hintText,
    String? errorText,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    bool? enabled = true,
    IconData? prefixIcon,
  })  : _textEditingController = controller,
        _label = label,
        _hintText = hintText,
        _errorText = errorText,
        _onChanged = onChanged,
        _keyboardType = keyboardType,
        _enabled = enabled,
        _prefixIcon = prefixIcon,
        super(key: key);

  final TextEditingController? _textEditingController;
  final String? _label;
  final String? _hintText;
  final String? _errorText;
  final Function(String)? _onChanged;
  final TextInputType? _keyboardType;
  final bool? _enabled;
  final IconData? _prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _errorText == null ? AppSize.s56.h : AppSize.s56.h + 20,
      child: TextField(
        enabled: _enabled,
        keyboardType: _keyboardType,
        minLines: null,
        maxLines: null,
        expands: true,
        onChanged: _onChanged,
        controller: _textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(_prefixIcon),
          hintText: _hintText,
          errorText: _errorText,
          label: _label == null ? null : Text(_label!),
        ),
      ),
    );
  }
}

class FullOutlinedButton extends StatelessWidget {
  const FullOutlinedButton({
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
      height: AppSize.s56,
      child: OutlinedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
