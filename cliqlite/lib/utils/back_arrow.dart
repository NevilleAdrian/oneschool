import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({this.onTap, this.text});

  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return InkWell(
        onTap: onTap ?? () => Navigator.pop(context),
        child: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_outlined,
            color: blackColor,
          ),
          title: Text(
            text ?? '',
            style: textStyleSmall.copyWith(
                fontSize: 21.0,
                fontWeight: FontWeight.w600,
                color: primaryColor),
          ),
        ));
  }
}
