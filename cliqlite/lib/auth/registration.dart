import 'package:cliqlite/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  static String id = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_ios),
                  kSmallWidth,
                  Text(
                    'Back',
                    style: textLightBlack,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
