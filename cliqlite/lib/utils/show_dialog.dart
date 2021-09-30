import 'package:cliqlite/utils/x_button.dart';
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
