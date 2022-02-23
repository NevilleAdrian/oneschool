import 'package:cliqlite/screens/home/check_back.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/dropdown.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:flutter/material.dart';

class MyPoints extends StatefulWidget {
  static String id = "my_points";

  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackArrow(),
              kLargeHeight,
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: lighterPrimaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My points',
                          style: smallPrimaryColor.copyWith(fontSize: 16),
                        ),
                        DropDown(
                          text: 'All Time',
                          color: primaryColor,
                        )
                      ],
                    ),
                    kSmallHeight,
                    Text(
                      '360',
                      style: headingPrimaryColor.copyWith(
                          fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              kSmallHeight,
              GreenButton(
                submit: () => Navigator.pushNamed(context, CheckBack.id),
                color: primaryColor,
                name: 'Use point',
                buttonColor: secondaryColor,
                loader: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
