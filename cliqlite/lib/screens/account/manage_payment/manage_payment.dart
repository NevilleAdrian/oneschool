import 'package:cliqlite/models/cards/cards.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/payment_summary.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagePayoutInfo extends StatefulWidget {
  ManagePayoutInfo(
      {this.show, this.type, this.amount, this.subId, this.childId});
  final String show;
  final String type;
  final int amount;
  final String subId;
  final String childId;

  @override
  _ManagePayoutInfoState createState() => _ManagePayoutInfoState();
}

class _ManagePayoutInfoState extends State<ManagePayoutInfo> {
  Future<List<GetCards>> futureCards;
  int number = 0;
  String cardId;

  //Global Key
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Future<List<GetCards>> futureTask() async {
    //Initialize provider
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(context);

    //Make call to get videos
    try {
      var result = await subscription.getCards();

      setState(() {});

      cardId = subscription.cards.isEmpty
          ? ''
          : SubscriptionProvider.subscribe(context).cards[0].id;

      print('result:$result');

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  // Widget addCard(BuildContext context) {
  //   return Container(
  //     padding: defaultVHPadding,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             XButton(
  //               onTap: () => Navigator.pop(context),
  //             ),
  //           ],
  //         ),
  //         kSmallHeight,
  //         Padding(
  //           padding: const EdgeInsets.only(left: 15),
  //           child: Text('Add new card',
  //               style: headingPrimaryColor.copyWith(fontSize: 21)),
  //         ),
  //         kSmallHeight,
  //         CreditCardForm(
  //           formKey: formKey,
  //           textColor: primaryColor,
  //           cursorColor: primaryColor,
  //           // Required
  //           onCreditCardModelChange: (CreditCardModel data) {
  //             print('data:${data.cardNumber}');
  //           }, // Required
  //           themeColor: primaryColor,
  //           obscureCvv: true,
  //           obscureNumber: true,
  //           isHolderNameVisible: true,
  //           isCardNumberVisible: true,
  //           isExpiryDateVisible: true,
  //           cardNumberDecoration: InputDecoration(
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(color: primaryColor, width: 1)),
  //               border: UnderlineInputBorder(),
  //               labelText: 'Card Number',
  //               hintText: '**** **** **** **** ',
  //               labelStyle: TextStyle(color: primaryColor)),
  //           expiryDateDecoration: const InputDecoration(
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(color: primaryColor, width: 1)),
  //               border: UnderlineInputBorder(),
  //               labelText: 'Month/Day',
  //               hintText: 'XX/XX',
  //               labelStyle: TextStyle(color: primaryColor)),
  //           cvvCodeDecoration: const InputDecoration(
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(color: primaryColor, width: 1)),
  //               border: UnderlineInputBorder(),
  //               labelText: 'CVV',
  //               hintText: '***',
  //               labelStyle: TextStyle(color: primaryColor)),
  //           cardHolderDecoration: const InputDecoration(
  //               focusedBorder: UnderlineInputBorder(
  //                   borderSide: BorderSide(color: primaryColor, width: 1)),
  //               border: UnderlineInputBorder(),
  //               labelText: 'Card Holder',
  //               labelStyle: TextStyle(color: primaryColor)),
  //         ),
  //         kLargeHeight,
  //         GreenButton(
  //           submit: () async =>
  //               await SubscriptionProvider.subscribe(context).addCard(),
  //           color: primaryColor,
  //           name: 'Add Card',
  //           loader: false,
  //           buttonColor: secondaryColor,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  nextPage(BuildContext context, String type, int amount, String subId,
      String childId, String cardId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentSummary(
                  type: type,
                  amount: amount,
                  subId: subId,
                  childId: childId,
                  cardId: cardId,
                )));
  }

  Widget cardScreen() {
    List<GetCards> cards = SubscriptionProvider.subscribe(context).cards;

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
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppLayout(
                                  index: 3,
                                )),
                        (Route<dynamic> route) => false),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: blackColor,
                    )),
                Text(
                  "Manage payout info",
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
            cards.isEmpty
                ? Center(
                    child: SvgPicture.asset('assets/images/svg/no_cards.svg'),
                  )
                : Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => kSmallHeight,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          var card = cards[index];
                          return CardDescription(
                            type: card.card.cardType,
                            card: card.card.last4,
                            id: card.id,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: cards[number] == cards[index]
                                      ? accentColor
                                      : Colors.transparent,
                                )),
                            onPressed: () {
                              setState(() {});
                              number = index;
                              cardId = cards[index].id;
                              print('number:$number');
                            },
                          );
                        }),
                  ),
            kLargeHeight,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async =>
                        await SubscriptionProvider.subscribe(context)
                            .addCard(context),
                    child: SvgPicture.asset(
                      'assets/images/svg/add_card.svg',
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            kSmallHeight,
            if (widget.show == 'show')
              GreenButton(
                submit: () => nextPage(context, widget.type, widget.amount,
                    widget.subId, widget.childId, cardId),
                color: primaryColor,
                name: 'Continue',
                buttonColor: secondaryColor,
                loader: false,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureCards = futureTask();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'cardssss: ${SubscriptionProvider.subscribe(context, listen: true).cards.length}');
    return BackgroundImage(
      child: FutureHelper(
        task: futureCards,
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
        builder: (context, _) => cardScreen(),
      ),
    );
  }
}

class CardDescription extends StatefulWidget {
  const CardDescription(
      {this.card, this.id, this.type, this.onPressed, this.decoration});
  final String card;
  final String id;
  final String type;
  final Function onPressed;
  final BoxDecoration decoration;

  @override
  State<CardDescription> createState() => _CardDescriptionState();
}

class _CardDescriptionState extends State<CardDescription> {
  Widget cardType(String name) {
    if (name.trim() == 'visa') {
      return Image.asset(
        'assets/images/visa.png',
      );
    } else if (name == 'mastercard') {
      return Image.asset('assets/images/master.png');
    } else {
      return Image.asset(
        'assets/images/verve.png',
        width: 40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Material(
        color: secondaryColor,
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: widget.decoration,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(8)),
          //   color: secondaryColor,
          // ),
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '**** **** **** ${widget.card}',
                        style: smallAccentColor.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      kSmallHeight,
                      cardType(widget.type)
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await SubscriptionProvider.subscribe(context)
                          .deleteCard(widget.id, context);
                    },
                    child: Center(
                      child: Icon(Icons.delete),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
