import 'package:cliqlite/utils/x_button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

dynamic dialogBox(BuildContext context, Widget widget, {Function onTap}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          title: XButton(
            onTap: onTap,
          ),
          content: widget,
        );
      });
}

void showFlush(BuildContext context, String message, Color color) {
  Flushbar(
    backgroundColor: color,
    message: message,
    duration: Duration(seconds: 7),
    flushbarStyle: FlushbarStyle.GROUNDED,
  ).show(context);
}
