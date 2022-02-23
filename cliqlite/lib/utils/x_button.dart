import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  XButton({this.onTap, this.color});
  final Function onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.clear,
            color: color ?? primaryColor,
          ),
        )
      ],
    );
  }
}
