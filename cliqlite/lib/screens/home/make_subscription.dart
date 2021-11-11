import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/make_payment/make_payment.dart';
import 'package:cliqlite/models/subscription_model/all_subscriptions/all_subscriptions.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

enum Attribute { yearly, monthly }

class MakeSubscription extends StatefulWidget {
  static String id = 'make_subscription';
  @override
  _MakeSubscriptionState createState() => _MakeSubscriptionState();
}

class _MakeSubscriptionState extends State<MakeSubscription> {
  Attribute val = Attribute.yearly;
  String subId;
  String childId;
  int amount;

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
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, _) => kSmallHeight,
                  itemCount: subscription.allSubscription.length,
                  itemBuilder: (context, index) {
                    final sub = subscription.allSubscription[index];
                    return SubscriptionBox(
                        title: sub.title == "Monthly Subscription"
                            ? 'Monthly'
                            : 'Yearly',
                        type: sub.title == "Monthly Subscription"
                            ? 'month'
                            : 'year',
                        subTitle: addSeparator(toDecimalPlace(
                            double.parse(sub.amount.toString()))),
                        attribute: sub.title == "Monthly Subscription"
                            ? Attribute.monthly
                            : Attribute.yearly,
                        groupVal: val,
                        decoration: decoration.copyWith(
                            borderRadius: BorderRadius.circular(40),
                            color: whiteColor,
                            border: Border.all(color: secondaryColor)),
                        val: sub.title == "Monthly Subscription"
                            ? Attribute.monthly
                            : Attribute.yearly,
                        onChanged: (Attribute value) {
                          setState(() {
                            val = value;
                            subId = val == Attribute.monthly
                                ? subscription.allSubscription[1].id
                                : subscription.allSubscription[0].id;
                            amount = val == Attribute.monthly
                                ? subscription.allSubscription[1].amount
                                : subscription.allSubscription[0].amount;
                          });
                        });
                  }),
            ),
            kSmallHeight,
            LargeButton(
              submit: () => nextPage(),
              color: primaryColor,
              name: 'Proceed',
              buttonColor: secondaryColor,
              loader: auth.isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Proceed',
                      style: headingWhite.copyWith(
                        color: secondaryColor,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage() async {
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);
    try {
      MakePayment(
        ctx: context,
        amount: amount ?? subscription.allSubscription[0].amount,
        email: AuthProvider.auth(context).user.email,
      ).chargeCardAndMakePayment(subId, childId);
    } catch (ex) {
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
    }
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
