import 'dart:io';

import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/payment/payment_page.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class MakePayment {
  MakePayment({
    this.ctx,
    this.amount,
    this.email,
    this.type,
  });

  BuildContext ctx;
  int amount;
  String email;
  String type;

  PaystackPlugin payStack = PaystackPlugin();

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'CliqLiteChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardUi() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await payStack.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  dynamic chargeCardAndMakePayment(
      String subId, String childId, BuildContext context,
      [String cardId]) async {
    SubscriptionProvider subscription = SubscriptionProvider.subscribe(ctx);
    try {
      var data = await SubscriptionProvider.subscribe(ctx).addSubscription(
          subId ?? subscription.allSubscription[0].id, type, childId, cardId);
      print('dataaa:$data');
      if (data != null) {
        AuthProvider.auth(context).setIsLoading(false);
        print('loading:${AuthProvider.auth(context).isLoading}');
        if (data['data'].isEmpty) {
          AuthProvider.auth(context).setIsLoading(false);
          Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (context) => AppLayout(
                        index: 3,
                      )));
          showFlush(ctx, data['message'], primaryColor);

          print('dataaa: $data');
        } else {
          Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (context) => PaymentPage(
                        url: data['data']['data']['authorization_url'],
                      )));
        }
      }
    } catch (ex) {
      print('ex...$ex');
      showFlush(ctx, ex.toString(), primaryColor);
    }

    // initializePlugin().then((_) async {
    //   Charge charge = Charge()
    //     ..amount = amount * 100
    //     ..email = email
    //     ..reference = _getReference()
    //     ..card = _getCardUi();
    //
    //   CheckoutResponse response = await payStack.checkout(ctx,
    //       charge: charge, method: CheckoutMethod.card, fullscreen: false);
    //   if (response.status == true) {
    //     print('Successful');
    //     try {
    //       var data = await SubscriptionProvider.subscribe(ctx).addSubscription(subId ?? subscription.allSubscription[0].id, childId);
    //       if (data != null) {
    //         try {
    //           data = await SubscriptionProvider.subscribe(ctx)
    //               .verifySubscription(data['data']['_id'], response.reference);
    //           print('dataaa:$data');
    //           if (data != null) {
    //             showFlush(ctx, 'Subscription successful', primaryColor);
    //             Future.delayed(Duration(seconds: 3), () {
    //               Navigator.push(
    //                   ctx,
    //                   MaterialPageRoute(
    //                       builder: (context) => AppLayout(
    //                             index: 0,
    //                           )));
    //             });
    //             return data;
    //           }
    //         } catch (ex) {
    //           print('ex...$ex');
    //           showFlush(ctx, ex.toString(), primaryColor);
    //         }
    //       }
    //     } catch (ex) {
    //       print('new ex...$ex');
    //
    //       showFlush(ctx, ex.toString(), primaryColor);
    //     }
    //   } else {
    //     print('Failed');
    //   }
    // });
  }
}
