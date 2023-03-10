import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/models/transactions/transactions.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/payment_summary.dart';
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
  Attribute val;
  Future<Transactions> futureTransactions;

  Future<Transactions> futureTask() async {
    //Initialize provider
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);

    //Make call to get videos
    try {
      var trans = await subscription.getTransactions();
      var result = await subscription.getSubscription();

      setState(() {});

      print('resultsss:$result');
      print('trans:$trans');

      val = trans.subscription.type == 'recurring'
          ? Attribute.recurring
          : Attribute.onetime;

      //Return future value
      return Future.value(trans);
    } catch (ex) {}
  }

  void toggleSub(String subId, String type) async {
    await SubscriptionProvider.subscribe(context)
        .toggleSubscription(subId, type);
  }

  Widget subscriptionScreen() {
    List<Subscription> subscription =
        SubscriptionProvider.subscribe(context).subscription;
    Transactions transactions =
        SubscriptionProvider.subscribe(context).transactions;

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
            // subscription == null
            //     ? Text('No Billing Information')
            //     :
            // subscription.isEmpty
            //     ? Container(
            //         child: Text(
            //           'No Subscription Found ',
            //           style: smallPrimaryColor,
            //         ),
            //       )
            //     :

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BillingPlan(
                //   text: 'Your Plan',
                //   subText:
                //       'Your current plan is - ???${addSeparator(toDecimalPlace(double.parse(subscription[0].subscription.amount.toString())))}month',
                //   addedText: '1 Child',
                // ),
                // kLargeHeight,
                // BillingPlan(
                //   text: 'Your next bill',
                //   subText:
                //       '${DateFormat("d MMM h:mma").format(subscription[0].user.subscriptionDueDate).toString() ?? ''}',
                // ),
                BillingPlan(
                  text: 'Your Plan',
                  subText:
                      'Your current plan is ${transactions?.plan?.name} for ${transactions.child.name}',
                  // subText:
                  //     'Your current plan is ???${addSeparator(toDecimalPlace(double.parse(subscription[0].plan.price.toString())))}month',
                  // addedText: ' ',
                ),
                kSmallHeight,
                BillingPlan(
                  text: 'Your next billing date',
                  subText:
                      '${DateFormat("d MMM yyy h:mma").format(transactions.expireAt)}',
                ),
                if (transactions.plan.name != 'free')
                  Container(
                    height: 150,
                    decoration: decoration.copyWith(
                        borderRadius: BorderRadius.circular(20),
                        color: lightPrimaryColor,
                        border: Border.all(color: lightPrimaryColor)),
                    child: ListView.separated(
                      separatorBuilder: (context, _) => kVerySmallHeight,
                      itemCount: paymentType.length,
                      itemBuilder: (context, index) {
                        final sub = paymentType[index];

                        print('payment:$paymentType');

                        return PaymentBox(
                            title: sub == "one-off"
                                ? 'One-time payment'
                                : 'Recurring Payment',
                            attribute: sub == "one-off"
                                ? Attribute.onetime
                                : Attribute.recurring,
                            groupVal: val,
                            val: sub == "one-off"
                                ? Attribute.onetime
                                : Attribute.recurring,
                            onChanged: (Attribute value) {
                              setState(() {
                                val = value;
                                print('val:$val');
                              });
                              toggleSub(
                                  subscription[0].id,
                                  val == Attribute.onetime
                                      ? 'one-off'
                                      : 'recurring');
                            });
                      },
                    ),
                  )
              ],
            ),
            kSmallHeight,
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: transactions.length,
            //       itemBuilder: (context, index) {
            //         var transaction = transactions[index];
            //         return BillingDescription(
            //           date: DateFormat("dd MMM y")
            //               .format(transaction.createdAt)
            //               .toString(),
            //           timeStamp: DateFormat("h: mma")
            //               .format(transaction.createdAt)
            //               .toString(),
            //           // number: transaction['card_number'],
            //           amount: transaction.amount.toString(),
            //         );
            //       }),
            // )
            Divider(
              height: 5,
              thickness: 0.6,
              color: greyColor,
            ),

            // if (transactions != null)
            //   transactions.isEmpty
            //       ? Container(
            //           child: Text(
            //             'No Transaction Found ',
            //             style: smallPrimaryColor,
            //           ),
            //         )
            //       : Expanded(
            //           child: ListView.builder(
            //               itemCount: 5,
            //               itemBuilder: (context, index) {
            //                 var transaction = transactions[index];
            //                 return BillingDescription(
            //                   date: DateFormat("dd MMM y")
            //                       .format(DateTime.now())
            //                       .toString(),
            //                   timeStamp: DateFormat("h: mma")
            //                       .format(DateTime.now())
            //                       .toString(),
            //                   // number: transaction['card_number'],
            //                   amount: '500',
            //                 );
            //               }),
            //         )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureTransactions = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: FutureHelper(
        task: futureTransactions,
        loader: SubscriptionProvider.subscribe(context).subscription == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [circularProgressIndicator()],
              )
            : subscriptionScreen(),
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
                  style: smallAccentColor.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                kSmallHeight,
                Text(
                  timeStamp,
                  style: smallPrimaryColor.copyWith(fontSize: 16),
                ),
                kSmallHeight,
                // Row(
                //   children: [
                //     Image.asset('assets/images/visa.png'),
                //     kVerySmallWidth,
                //     Text(
                //       number,
                //       style: textExtraLightBlack.copyWith(fontSize: 16),
                //     ),
                //   ],
                // )
              ],
            ),
            Text(
              '???$amount',
              style: headingPrimaryColor.copyWith(fontSize: 18),
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
          style: smallAccentColor.copyWith(fontSize: 16),
        ),
        kVerySmallHeight,
        Text(
          subText,
          style: headingPrimaryColor.copyWith(fontSize: 16),
        ),
        kVerySmallHeight,
        Text(
          addedText ?? '',
          style: headingPrimaryColor.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
