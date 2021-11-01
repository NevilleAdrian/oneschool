import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:flutter/material.dart';

enum Attribute { yearly, monthly }

class MakeSubscription extends StatefulWidget {
  static String id = 'make_subscription';
  @override
  _MakeSubscriptionState createState() => _MakeSubscriptionState();
}

class _MakeSubscriptionState extends State<MakeSubscription> {
  Attribute val = Attribute.yearly;

  nextPage() {
    print('hye');
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.chevron_left,
                          color: blackColor,
                        )),
                    Text(
                      "Subscription",
                      textAlign: TextAlign.center,
                      style: textStyleSmall.copyWith(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    Container()
                  ],
                ),
                kLargeHeight,
                Text(
                  'Choose your Plan',
                  style: textExtraLightBlack.copyWith(fontSize: 18),
                ),
                kSmallHeight,
                SubscriptionBox(
                    title: 'Monthly',
                    type: 'month',
                    subTitle: '1,800',
                    attribute: Attribute.monthly,
                    groupVal: val,
                    decoration: decoration.copyWith(
                        borderRadius: BorderRadius.circular(40),
                        color: whiteColor,
                        border: Border.all(
                            color: val == Attribute.monthly
                                ? secondaryColor
                                : whiteColor)),
                    val: Attribute.monthly,
                    onChanged: (Attribute value) {
                      setState(() {
                        val = value;
                      });
                    }),
                kSmallHeight,
                SubscriptionBox(
                    title: 'Annually',
                    subTitle: '15,000',
                    type: 'year',
                    attribute: Attribute.yearly,
                    decoration: decoration.copyWith(
                        borderRadius: BorderRadius.circular(40),
                        color: whiteColor,
                        border: Border.all(
                            color: val == Attribute.yearly
                                ? secondaryColor
                                : whiteColor)),
                    groupVal: val,
                    val: Attribute.yearly,
                    onChanged: (Attribute value) {
                      setState(() {
                        val = value;
                      });
                    }),
                kSmallHeight,
                LargeButton(
                  submit: () => nextPage(),
                  color: primaryColor,
                  name: 'Proceed',
                  buttonColor: secondaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SubscriptionBox extends StatelessWidget {
  SubscriptionBox(
      {this.attribute,
      this.title,
      this.type,
      this.subTitle,
      this.val,
      this.decoration,
      this.onChanged,
      this.groupVal});
  Attribute attribute;
  String title;
  String type;
  Attribute val;
  Attribute groupVal;
  String subTitle;
  Function onChanged;
  BoxDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shadowColor: secondaryColor,
      elevation: 1,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textExtraLightBlack.copyWith(fontSize: 18),
                ),
                kSmallHeight,
                Text(
                  '₦$subTitle/$type',
                  style: textLightBlack.copyWith(fontSize: 18),
                ),
                kVerySmallHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1 quiz trial then ₦$subTitle',
                      style: textExtraLightBlack.copyWith(fontSize: 16),
                    ),
                    Text(
                      'per month. Cancel anytime.',
                      style: textExtraLightBlack.copyWith(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio(
                  value: attribute,
                  groupValue: groupVal,
                  activeColor: secondaryColor,
                  onChanged: onChanged,
                ),
                Container(
                  height: 14,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
