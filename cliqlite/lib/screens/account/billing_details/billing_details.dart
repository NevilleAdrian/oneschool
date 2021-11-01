import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillingDetails extends StatefulWidget {
  @override
  _BillingDetailsState createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails> {
  Future<Subscription> futureSubscriptions;

  Future<Subscription> futureTask() async {
    //Initialize provider
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);

    //Make call to get videos
    try {
      var result = await subscription.getSubscription();

      setState(() {});

      print('result:$result');

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  Widget subscriptionScreen() {
    Subscription subscription =
        SubscriptionProvider.subscribe(context).subscription;

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
                  "Billing Details",
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
            BillingPlan(
              text: 'Your Plan',
              subText:
                  'Your current plan is - ₦${addSeparator(toDecimalPlace(double.parse(subscription.subscription.amount.toString())))}month',
              addedText: '1 Child',
            ),
            kLargeHeight,
            BillingPlan(
              text: 'Your next bill',
              subText:
                  '${DateFormat("d MMM h:mma").format(subscription.user.subscriptionDueDate).toString() ?? ''}',
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: billingData.length,
                  itemBuilder: (context, index) {
                    var billing = billingData[index];
                    return BillingDescription(
                      date: billing['date'],
                      timeStamp: billing['timeStamp'],
                      number: billing['card_number'],
                      amount: billing['amount'],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureSubscriptions = futureTask();
    super.initState();
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
          children: [Text('No data available')],
        ),
        builder: (context, _) => subscriptionScreen(),
      ),
    );
  }
}

class BillingDescription extends StatelessWidget {
  const BillingDescription(
      {this.date, this.timeStamp, this.number, this.amount});
  final String date;
  final String timeStamp;
  final String number;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kSmallHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: smallPrimaryColor.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                kSmallHeight,
                Text(
                  timeStamp,
                  style: textExtraLightBlack.copyWith(fontSize: 16),
                ),
                kSmallHeight,
                Row(
                  children: [
                    Image.asset('assets/images/visa.png'),
                    kVerySmallWidth,
                    Text(
                      number,
                      style: textExtraLightBlack.copyWith(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
            Text(
              '₦$amount',
              style: textExtraLightBlack.copyWith(fontSize: 18),
            )
          ],
        ),
        kSmallHeight,
        Divider(
          height: 5,
          thickness: 0.6,
          color: greyColor,
        ),
      ],
    );
  }
}

class BillingPlan extends StatelessWidget {
  const BillingPlan({this.text, this.subText, this.addedText});
  final String text;
  final String subText;
  final String addedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: textGrey,
        ),
        kVerySmallHeight,
        Text(
          subText,
          style: textLightBlack,
        ),
        kVerySmallHeight,
        Text(
          addedText ?? '',
          style: textLightBlack,
        ),
      ],
    );
  }
}
