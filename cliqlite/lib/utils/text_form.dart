import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  const MyTextForm({
    Key key,
    @required TextEditingController controllerName,
    this.validations,
    this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.type = TextInputType.text,
    this.hintText = '',
    this.area,
    this.hintColor,
    this.fillColor,
    this.enabled,
    this.borderWidth,
    this.readonly,
  })  : _controllerName = controllerName,
        super(key: key);

  final TextEditingController _controllerName;
  final Function validations;
  final String label;
  final int area;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType type;
  final String hintText;
  final Color hintColor;
  final Color fillColor;
  final Color enabled;
  final double borderWidth;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _controllerName,
        keyboardType: type,
        style: TextStyle(color: primaryColor, fontFamily: "Montserrat"),
        validator: validations,
        obscureText: obscureText,
        maxLines: area,
        readOnly: readonly ?? false,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: enabled ?? greyColor,
                width: borderWidth ?? 0.3,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: enabled ?? accentColor,
                width: borderWidth ?? 1.0,
              ),
            ),
            suffixIcon: suffixIcon,
            prefix: prefixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            hintText: hintText,
            fillColor: fillColor ?? lightPrimaryColor,
            filled: true,
            labelStyle: TextStyle(color: Colors.grey),
            hintStyle: TextStyle(
                color: hintColor ?? greyColor,
                fontFamily: "Montserrat",
                fontSize: 16)));
  }
}
