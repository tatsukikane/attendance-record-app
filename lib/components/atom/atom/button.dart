import 'package:attendance_record_app/components/atom/atom/tappable.dart';
import 'package:attendance_record_app/components/atom/atom/text_widget.dart';
import 'package:flutter/material.dart';

class Button extends Tappable {
  Button({
    Key? key,
    String title = "",
    Widget? titleWidget,
    required Function onTap,
    required double height,
    double? width,
    Color? color,
    bool isActive = true,
    EdgeInsets? padding,
  }) : super(
          key: key,
          onTap: isActive ? onTap : null,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: isActive
                  ? (color ?? Colors.green)
                  : Colors.blueGrey,
              borderRadius: BorderRadius.circular(24),
            ),
            height: height,
            width: width,
            child: Center(
              child: titleWidget ??
                  TextWidget(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive
                        ? Colors.white
                        : Colors.black,
                  ),
            ),
          ),
        );
}