import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
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

class GreenButton extends StatefulWidget {
  const GreenButton(
      {this.submit,
      this.color,
      this.name,
      this.buttonColor,
      this.height,
      this.loader,
      this.gradColor});

  final Function submit;
  final Color color;
  final String name;
  final Color buttonColor;
  final double height;
  final bool loader;
  final Color gradColor;

  @override
  State<GreenButton> createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.submit,
      child: Container(
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                widget.gradColor ?? Color(0XFF014CD9),
                widget.gradColor ?? Color(0XFF0179E9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 27),
              child: widget.loader
                  ? circularProgressIndicator()
                  : Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
