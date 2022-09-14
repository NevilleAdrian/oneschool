import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/auth/registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  img: 'assets/images/parents.png',
                  attribute: Attribute.parent,
                  groupVal: val,
                  decoration: decoration.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      color: lightPrimaryColor,
                      border: Border.all(color: secondaryColor)),
                  onChanged: () {
                    setState(() {
                      val = Attribute.parent;
                    });
                  },
                ),
                kSmallHeight,
                OptionBox(
                    title: 'I am a Student/Child',
                    subTitle: 'I want to set up my own account',
                    img: 'assets/images/children 1.png',
                    attribute: Attribute.child,
                    decoration: decoration.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        color: lightPrimaryColor,
                        border: Border.all(color: secondaryColor)),
                    groupVal: val,
                    onChanged: () {
                      setState(() {
                        val = Attribute.child;
                      });
                    }),
                kSmallHeight,
                InkWell(
                  onTap: () => nextPage(val),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0XFF014CD9),
                            Color(0XFF0179E9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                ),
                // LargeButton(
                //   submit: () => nextPage(val),
                //   color: primaryColor,
                //   name: 'Continue',
                //   buttonColor: secondaryColor,
                // ),
                // kLargeHeight,
                // HaveAccount()
              ],
            ),
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
      this.img,
      this.decoration,
      this.onChanged,
      this.groupVal});
  Attribute attribute;
  String title;
  String img;
  Attribute groupVal;
  String subTitle;
  Function onChanged;
  BoxDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.only(right: 20, top: 10, bottom: 30, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                groupVal == attribute
                    ? SvgPicture.asset(
                        'assets/images/svg/checked.svg',
                        height: 25,
                      )
                    : SvgPicture.asset(
                        'assets/images/svg/unchecked.svg',
                        height: 25,
                      )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(img),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textLightBlack.copyWith(color: primaryColor),
                ),
                kVerySmallHeight,
                Text(
                  subTitle,
                  style: textGrey.copyWith(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
