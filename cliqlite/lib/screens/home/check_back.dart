import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';

class CheckBack extends StatefulWidget {
  static String id = "check_back";

  @override
  _CheckBackState createState() => _CheckBackState();
}

class _CheckBackState extends State<CheckBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackArrow(),
              kLargeHeight,
              Image.asset('assets/images/bolts.png'),
              kLargeHeight,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Check back later. This feature is under development.',
                  style: smallPrimaryColor.copyWith(
                      color: accentColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
