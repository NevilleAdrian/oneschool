import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class LineButton extends StatelessWidget {
  const LineButton({this.text, this.onPressed, this.height, this.loader});
  final String text;
  final Function onPressed;
  final double height;
  final Widget loader;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        height: height ?? 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
              side: BorderSide(width: 1, color: primaryColor)),
          elevation: 0.0,
          color: Colors.transparent,
          icon: new Text(''),
          label: loader ??
              Text(
                text,
                style: headingPrimaryColor.copyWith(fontSize: 15),
              ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
