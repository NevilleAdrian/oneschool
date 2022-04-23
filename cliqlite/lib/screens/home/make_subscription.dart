import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subscription_model/all_subscriptions/all_subscriptions.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/payment_summary.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

enum Attribute { yearly, monthly, quaterly, daily }

class MakeSubscription extends StatefulWidget {
  static String id = 'make_subscription';
  @override
  _MakeSubscriptionState createState() => _MakeSubscriptionState();
}

class _MakeSubscriptionState extends State<MakeSubscription> {
  Attribute val = Attribute.yearly;
  String subId;
  String childId;
  String type;
  int amount;
  int number = 0;

  @override
  void initState() {
    futureSubscriptions = futureTask();
    super.initState();
  }

  Future<List<AllSubscriptions>> futureSubscriptions;

  Future<List<AllSubscriptions>> futureTask() async {
    //Initialize provider
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);

    //Make call to get videos
    try {
      var result = await subscription.getAllSubscription();
      setState(() {});
      ChildIndex childIndex = SubjectProvider.subject(context).index;
      List<Users> users = AuthProvider.auth(context).users;
      MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

      childId =
          users != null ? users[childIndex?.index ?? 0].id : mainChildUser.id;

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  Widget subscriptionScreen() {
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);
    AuthProvider auth = AuthProvider.auth(context);

    return SafeArea(
      child: Padding(
        padding: defaultVHPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_outlined,
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
              style: headingPrimaryColor.copyWith(fontSize: 18),
            ),
            kSmallHeight,
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, _) => kSmallHeight,
                  itemCount: subscription.allSubscription.length,
                  itemBuilder: (context, index) {
                    final sub = subscription.allSubscription[index];
                    return SubscriptionBox(
                        title: sub.type == "monthly"
                            ? 'Monthly'
                            : (sub.type == "yearly"
                                ? 'Yearly'
                                : (sub.type == "quarterly"
                                    ? 'Quarterly'
                                    : "Daily")),
                        type: sub.type == "monthly"
                            ? 'Monthly'
                            : (sub.type == "yearly"
                                ? 'Yearly'
                                : (sub.type == "quarterly"
                                    ? 'Quarterly'
                                    : "Daily")),
                        subTitle: addSeparator(toDecimalPlace(
                            int.parse(sub.price.toString()) ?? 0)),
                        attribute: sub.type == "monthly"
                            ? Attribute.monthly
                            : (sub.type == "yearly"
                                ? Attribute.yearly
                                : (sub.type == "quarterly"
                                    ? Attribute.quaterly
                                    : Attribute.daily)),
                        groupVal: val,
                        decoration: decoration.copyWith(
                            borderRadius: BorderRadius.circular(20),
                            color: lightPrimaryColor,
                            border: Border.all(
                                color: subscription.allSubscription[number] ==
                                        subscription.allSubscription[index]
                                    ? accentColor
                                    : Colors.transparent)),
                        val: sub.type == "monthly"
                            ? Attribute.monthly
                            : (sub.type == "yearly"
                                ? Attribute.yearly
                                : (sub.type == "quarterly"
                                    ? Attribute.quaterly
                                    : Attribute.daily)),
                        onChanged: (Attribute value) {
                          setState(() {
                            val = value;
                            number = index;
                            print('number:$number');
                            print('number:$index');
                            subId = sub.id;
                            amount = sub.price;
                            type = sub.type;
                          });
                        });
                  }),
            ),
            kSmallHeight,
            GreenButton(
              submit: () => nextPage(
                  context,
                  type ?? subscription.allSubscription[0].type,
                  amount ?? subscription.allSubscription[0].price,
                  subId,
                  childId),
              color: primaryColor,
              name: 'Continue',
              buttonColor: secondaryColor,
              loader: AuthProvider.auth(context).isLoading,
            ),
          ],
        ),
      ),
    );
  }

  nextPage(BuildContext context, String type, int amount, String subId,
      String childId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentSummary(
                  type: type,
                  amount: amount,
                  subId: subId,
                  childId: childId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: FutureHelper(
        task: futureSubscriptions,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        noData: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No Subscriptions')],
        ),
        builder: (context, _) => subscriptionScreen(),
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
      elevation: 0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: decoration,
        padding: EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: smallAccentColor.copyWith(fontSize: 16),
                  ),
                  kSmallHeight,
                  Text(
                    '₦$subTitle/$type',
                    style: smallPrimaryColor.copyWith(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  kSmallHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1 quiz trial then ₦$subTitle per ',
                        style: smallPrimaryColor.copyWith(fontSize: 16),
                      ),
                      Text(
                        '$type per child. Cancel anytime.',
                        style: smallPrimaryColor.copyWith(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio(
                  value: attribute,
                  groupValue: groupVal,
                  activeColor: accentColor,
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
