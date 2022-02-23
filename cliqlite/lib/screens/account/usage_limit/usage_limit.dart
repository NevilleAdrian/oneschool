import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';

class UsageLimit extends StatefulWidget {
  @override
  _UsageLimitState createState() => _UsageLimitState();
}

class _UsageLimitState extends State<UsageLimit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackArrow(text: 'Set app usage limit'),
            Padding(
              padding: defaultPadding,
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
