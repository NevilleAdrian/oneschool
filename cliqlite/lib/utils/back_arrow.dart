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
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: theme.status ? whiteColor : blackColor,
            size: 15,
          ),
          Text(
            text ?? 'Back',
            style: theme.status
                ? textStyleWhite
                : textLightBlack.copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
