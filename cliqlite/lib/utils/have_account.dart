import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({this.text, this.subText});
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Login.id),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? 'Already have an account?',
            style: smallPrimaryColor.copyWith(color: blackColor),
          ),
          Text(
            subText ?? ' Login',
            style: smallPrimaryColor.copyWith(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
