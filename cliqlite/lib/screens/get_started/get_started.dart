import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/auth/registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  static String id = 'get-started';
  @override
  _GetStartedState createState() => _GetStartedState();
}

enum Attribute { parent, child }

class _GetStartedState extends State<GetStarted> {
  Attribute val = Attribute.parent;

  nextPage(Attribute val) {
    if (val == Attribute.parent) {
      Navigator.pushNamed(context, Registration.id);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChildRegistration(
                    user: 'parent',
                  )));
    }
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
                      borderRadius: BorderRadius.circular(40),
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
                      borderRadius: BorderRadius.circular(40),
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
                submit: () => nextPage(val),
                color: primaryColor,
                name: 'Continue',
                buttonColor: secondaryColor,
              ),
              kLargeHeight,
              HaveAccount()
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
      padding: EdgeInsets.only(right: 20, top: 30, bottom: 30),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Radio(
                value: attribute,
                groupValue: groupVal,
                activeColor: primaryColor,
                onChanged: onChanged,
              ),
              Container(
                height: 14,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textLightBlack,
              ),
              kVerySmallHeight,
              Text(
                subTitle,
                style: textExtraLightBlack.copyWith(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
