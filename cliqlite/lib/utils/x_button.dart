import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  XButton({this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.clear,
            color: blackColor,
          ),
        )
      ],
    );
  }
}
