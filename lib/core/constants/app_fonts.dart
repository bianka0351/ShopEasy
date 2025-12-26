import 'package:flutter/material.dart';

abstract class BaseTextStyle {
  static const String fontFamily = 'NotoRashiHebrew-Regular';
  static const double defaultFontSize = 14.0;
  static const Color defaultFontColor = Colors.black;

  static TextStyle textStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? defaultFontColor,
    );
  }
}

class AppFonts extends BaseTextStyle {
  static TextStyle notoLight({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      color: color,
    );
  }

  static TextStyle notoRegular({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle notoMedium({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static TextStyle notoSemiBold({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle notoBold({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle notoExtraBold({double? fontSize, Color? color}) {
    return BaseTextStyle.textStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      color: color,
    );
  }
}
