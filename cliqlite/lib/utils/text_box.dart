import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: smallPrimaryColor.copyWith(
              fontSize: 19, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
