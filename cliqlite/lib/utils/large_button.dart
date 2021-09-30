import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({this.submit, this.color, this.name, this.buttonColor});

  final Function submit;
  final Color color;
  final String name;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60.0,
      minWidth: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0)),
        elevation: 0.0,
        color: color,
        icon: new Text(''),
        label: new Text(
          name,
          style: headingWhite.copyWith(color: buttonColor),
        ),
        onPressed: submit,
      ),
    );
  }
}
