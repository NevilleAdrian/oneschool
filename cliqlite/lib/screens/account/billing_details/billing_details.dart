import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class BillingDetails extends StatefulWidget {
  @override
  _BillingDetailsState createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
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
                subText: 'Your current plan is - ₦3,600/month',
                addedText: '2 Children',
              ),
              kLargeHeight,
              BillingPlan(
                text: 'Your next bill',
                subText: '30th September 2021',
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
