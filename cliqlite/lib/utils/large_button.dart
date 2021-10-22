import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton(
      {this.submit,
      this.color,
      this.name,
      this.buttonColor,
      this.height,
      this.loader});

  final Function submit;
  final Color color;
  final String name;
  final Color buttonColor;
  final double height;
  final Widget loader;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height ?? 60.0,
      minWidth: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0)),
        elevation: 0.0,
        color: color,
        icon: new Text(''),
        label: loader ??
            Text(
              name,
              style: headingWhite.copyWith(color: buttonColor),
            ),
        onPressed: submit,
      ),
    );
  }
}
