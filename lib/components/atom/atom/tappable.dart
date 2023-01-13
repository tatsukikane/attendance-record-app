import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tappable extends InkWell {
  Tappable({
    Key? key,
    required Widget child,
    Function? onTap,
    Function? onLongPress,
    bool feedback = true,
  }) : super(
          key: key,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: child,
          onTap: onTap == null
              ? null
              : () {
                  if (feedback) {
                    HapticFeedback.lightImpact();
                  }
                  onTap.call();
                },
          onLongPress: onLongPress == null
              ? null
              : () {
                  if (feedback) {
                    HapticFeedback.lightImpact();
                  }
                  onLongPress.call();
                },
        );
}
