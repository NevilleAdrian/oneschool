import 'package:cliqlite/models/make_payment/make_payment.dart';
import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Attribute { onetime, recurring }

class PaymentSummary extends StatefulWidget {
  static String id = 'summary';

  PaymentSummary(
      {this.type, this.amount, this.subId, this.childId, this.cardId});
  final String type;
  final int amount;
  final String subId;
  final String childId;
  final String cardId;

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  Attribute val = Attribute.onetime;

  nextPage(BuildContext context) async {
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);
    AuthProvider.auth(context).setIsLoading(true);
    try {
      setState(() {});
      MakePayment(
              ctx: context,
              amount: widget.amount ?? subscription.allSubscription[0].price,
              email: AuthProvider.auth(context).user.email,
              type: val == Attribute.onetime ? 'one-off' : 'recurring')
          .chargeCardAndMakePayment(
              widget.subId, widget.childId, context, widget.cardId);
    } catch (ex) {
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
    }
  }

  @override
  void initState() {
    // print('amount: ${widget.amount}');
    // print('type: ${widget.type}');
    // print('cardId: ${widget.cardId}');
    super.initState();
  }

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
                        Icons.arrow_back_outlined,
                        color: blackColor,
                      )),
                  Text(
                    "Payment Summary",
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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Type',
                          style: smallAccentColor.copyWith(fontSize: 16),
                        ),
                        kSmallHeight,
                        Text(
                            '${toBeginningOfSentenceCase(widget.type)} subscription',
                            style: smallPrimaryColor.copyWith(fontSize: 16)),
                      ],
                    ),
                    kNormalHeight,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: smallAccentColor.copyWith(fontSize: 16),
                        ),
                        kSmallHeight,
                        Text(
                            'NGN ${addSeparator(toDecimalPlace(int.parse(widget.amount.toString()) ?? 0))}',
                            style: smallPrimaryColor.copyWith(fontSize: 16)),
                      ],
                    ),
                    kNormalHeight,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment preference',
                          style: smallAccentColor.copyWith(fontSize: 16),
                        ),
                        kSmallHeight,
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
                                  });
                            },
                          ),
                        )
                      ],
                    ),
                    kLargeHeight,
                    GreenButton(
                      submit: () => nextPage(context),
                      color: primaryColor,
                      name: 'Proceed to payment',
                      buttonColor: secondaryColor,
                      loader: AuthProvider.auth(context).isLoading,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentBox extends StatelessWidget {
  PaymentBox(
      {this.attribute, this.title, this.val, this.onChanged, this.groupVal});
  Attribute attribute;
  String title;
  Attribute val;
  Attribute groupVal;
  Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
          ],
        ),
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
            ],
          ),
        ),
      ],
    );
  }
}
