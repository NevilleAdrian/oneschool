import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({this.text, this.onTap, this.center});

  final String text;
  final Function onTap;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: center ?? true,
      leading: BackArrow(
        onTap: onTap ?? () => Navigator.pushNamed(context, GetStarted.id),
      ),
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyleSmall.copyWith(
            fontSize: 21.0, fontWeight: FontWeight.w700, color: primaryColor),
      ),
    );
  }
}
