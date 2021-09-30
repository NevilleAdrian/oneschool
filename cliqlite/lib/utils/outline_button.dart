import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class LineButton extends StatelessWidget {
  const LineButton({this.text, this.onPressed});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        height: 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
              side: BorderSide(width: 1, color: primaryColor)),
          elevation: 0.0,
          color: Colors.transparent,
          child: Text(
            text,
            style: headingPrimaryColor.copyWith(fontSize: 15),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
