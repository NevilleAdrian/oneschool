import 'package:cliqlite/auth/registration.dart';
import 'package:cliqlite/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/LargeButton.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

enum Attribute { parent, child }

class _GetStartedState extends State<GetStarted> {
  Attribute val = Attribute.parent;

  nextPage() {
    Navigator.pushNamed(context, Registration.id);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.clear, color: blackColor),
                ],
              ),
              kSmallHeight,
              Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
              kLargeHeight,
              OptionBox(
                  title: 'I am a Parent',
                  subTitle: 'I want to set up my child’s account',
                  attribute: Attribute.parent,
                  groupVal: val,
                  decoration: decoration.copyWith(
                      border: Border.all(
                          color: val == Attribute.parent
                              ? primaryColor
                              : greyColor)),
                  val: Attribute.parent,
                  onChanged: (Attribute value) {
                    setState(() {
                      val = value;
                    });
                  }),
              kSmallHeight,
              OptionBox(
                  title: 'I am a Student/Child',
                  subTitle: 'I want to set up my own account',
                  attribute: Attribute.child,
                  decoration: decoration.copyWith(
                      border: Border.all(
                          color: val == Attribute.child
                              ? primaryColor
                              : greyColor)),
                  groupVal: val,
                  val: Attribute.child,
                  onChanged: (Attribute value) {
                    setState(() {
                      val = value;
                    });
                  }),
              kLargeHeight,
              LargeButton(
                submit: () => nextPage(),
                color: primaryColor,
                name: 'Continue',
                buttonColor: secondaryColor,
              ),
              kLargeHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: smallPrimaryColor.copyWith(color: blackColor),
                  ),
                  Text(
                    ' Login',
                    style: smallPrimaryColor,
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

// ignore: must_be_immutable
class OptionBox extends StatelessWidget {
  OptionBox(
      {this.attribute,
      this.title,
      this.subTitle,
      this.val,
      this.decoration,
      this.onChanged,
      this.groupVal});
  Attribute attribute;
  String title;
  Attribute val;
  Attribute groupVal;
  String subTitle;
  Function onChanged;
  BoxDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      padding: EdgeInsets.only(right: 20, top: 10, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: attribute,
                groupValue: groupVal,
                activeColor: primaryColor,
                onChanged: onChanged,
              ),
              // kSmallWidth,
              Text(
                title,
                style: textLightBlack,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subTitle,
                style: textExtraLightBlack.copyWith(fontSize: 12),
              )
              // kSmallHeight,
            ],
          )
        ],
      ),
    );
  }
}
