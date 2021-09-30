import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTheme(
        height: 70.0,
        minWidth: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
              side: BorderSide(width: 1, color: primaryColor)),
          elevation: 0.0,
          color: Colors.transparent,
          icon: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [SvgPicture.asset('assets/images/svg/google.svg')],
          ),
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text ?? 'Sign in with Google',
                style: headingPrimaryColor.copyWith(fontSize: 15),
              )
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
