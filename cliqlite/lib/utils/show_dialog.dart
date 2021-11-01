import 'package:cliqlite/themes/style.dart';
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

Widget circularProgressIndicator() => CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
    );

String toDecimalPlace(dynamic item, [int value = 2]) {
  return item.toStringAsFixed(value);
}

String addSeparator(String item) {
  return item.replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}
