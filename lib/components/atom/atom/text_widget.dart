import 'package:flutter/material.dart';

bool isAllHankaku(String text) {
  String? hankaku = RegExp(r'[ -~]+').stringMatch(text);
  if (hankaku == null) {
    return false;
  }
  return hankaku == text;
}

class TextWidget extends Container {
  TextWidget({
    Key? key,
    required String text,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? fontHeight,
    TextAlign? textAlign,
    int? maxLines,
    bool setUnderline = false,
  }) : super(
          key: key,
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Text(
            text,
            textAlign: textAlign,
            maxLines: maxLines,
            style: TextStyle(
              color: color ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
              // fontFamily: isAllHankaku(text) ? "SFPro" : "NotoSansJP",
              height: fontHeight,
              letterSpacing: (fontSize ?? 14.0) * 0.04,
              decoration: setUnderline ? TextDecoration.underline : null,
            ),
          ),
        );
}
