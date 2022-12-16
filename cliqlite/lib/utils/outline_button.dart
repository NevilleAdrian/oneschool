import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class LineButton extends StatelessWidget {
  const LineButton(
      {this.text,
      this.onPressed,
      this.height,
      this.loader,
      this.fontSize,
      this.icon});
  final String text;
  final Function onPressed;
  final double height;
  final Widget loader;
  final double fontSize;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        height: height ?? 50.0,
        minWidth: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
                // side: BorderSide(width: 1, color: primaryColor)
              )),
              elevation: MaterialStatePropertyAll(0.0),
              backgroundColor: MaterialStatePropertyAll(lighterPrimaryColor)),
          icon: text != null
              ? Icon(
                  Icons.add,
                  color: primaryColor,
                )
              : Text(''),
          label: loader ??
              Text(
                text,
                style: headingPrimaryColor.copyWith(fontSize: fontSize ?? 15),
              ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  BorderButton({this.text, this.onTap, this.height});
  final String text;
  final Function onTap;
  final double height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(height ?? 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: accentColor, width: 0.9),
            color: Colors.white),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: smallPrimaryColor.copyWith(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
