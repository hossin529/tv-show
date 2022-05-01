import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/ui/utils/util.dart';

class Dialogs {
  static void showFlushBar(BuildContext context, String message,
      {int duration = 3, String? type}) {
    var borderColor;
    switch (type) {
      case 'danger':
        borderColor = Colors.red;
        break;
      case 'success':
        borderColor = Colors.green;
        break;
      case 'warning':
        borderColor = Style.primaryColor;
        break;
      default:
        borderColor = Style.placeHolderColor;
    }
    Flushbar(
      backgroundColor: borderColor,
      borderColor: borderColor,
      message: message,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      duration: Duration(seconds: duration),
    ).show(context);
  }
}
