import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, FontWeight fontWeight, Color color, String fontFamily) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// almarai regular style
TextStyle getAlmaraiRegularStyle(
    {required double fontSize, required Color color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color, FontConstants.almaraiFamily);
}

// almarai bold style
TextStyle getAlmaraiBoldStyle(
    {required double fontSize, required Color color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.bold, color, FontConstants.almaraiFamily);
}
