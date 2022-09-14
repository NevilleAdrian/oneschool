import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/cards/cards.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subscription_model/all_subscriptions/all_subscriptions.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/models/transactions/transactions.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/account/manage_payment/manage_payment.dart';
import 'package:cliqlite/screens/payment/payment_page.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class SubscriptionProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;

  List<Subscription> _subscription;
  List<AllSubscriptions> _allSubscription;
  Transactions _transactions;
  List<GetCards> _cards;

  List<Subscription> get subscription => _subscription;
  List<AllSubscriptions> get allSubscription => _allSubscription;
  Transactions get transactions => _transactions;
  List<GetCards> get cards => _cards;

  setSubscription(List<Subscription> subscription) =>
      _subscription = subscription;
  setAllSubscription(List<AllSubscriptions> allSubscription) =>
      _allSubscription = allSubscription;
  setTransactions(Transactions transactions) => _transactions = transactions;
  setCards(List<GetCards> cards) => _cards = cards;

  Future<List<GetCards>> getCards() async {
    //get subscription
    try {
      var data =
          await _helper.getCards(_context, AuthProvider.auth(_context).token);

      // data = Subscription.fromJson(data);
      data = (data as List).map((e) => GetCards.fromJson(e)).toList();

      print('cardData: $data');

      //Save subject in local storage
      setCards(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
    }
  }

  //add Subscription
  Future<dynamic> addCard(BuildContext ctx) async {
    // add a subscription
    try {
      var data =
          await _helper.addCard(AuthProvider.auth(_context).token, _context);

      if (data != null) {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (context) => PaymentPage(
                      url: data['data']['data']['authorization_url'],
                    )));
      }
    } catch (ex) {
      print('ex:$ex');
      showFlush(
          _context, toBeginningOfSentenceCase(ex.toString()), primaryColor);
    }
  }

  //add Subscription
  Future<dynamic> deleteCard(String id, BuildContext ctx) async {
    // add a subscription
    ProgressDialog dialog = new ProgressDialog(ctx);
    dialog.style(
        message: 'Please wait...', progressWidget: circularProgressIndicator());
    await dialog.show();
    try {
      var data = await _helper.deleteCard(
          id, AuthProvider.auth(_context).token, _context);

      if (data != null) {
        await dialog.hide();

        Navigator.push(
            ctx, MaterialPageRoute(builder: (context) => ManagePayoutInfo()));
      }
    } catch (ex) {
      print('ex:$ex');
      showFlush(
          _context, toBeginningOfSentenceCase(ex.toString()), primaryColor);
    }
  }

  Future<List<Subscription>> getSubscription() async {
    //initialize childIndex and users
    ChildIndex childIndex = SubjectProvider.subject(_context).index;
    List<Users> children = AuthProvider.auth(_context).users;
    MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;
    //get subscription
    try {
      var data = await _helper.getSubscription(
          _context,
          children != null
              ? children[childIndex?.index ?? 0].id
              : mainChildUser.id,
          AuthProvider.auth(_context).token);
      print('dsubscribedData: $data');

      // data = Subscription.fromJson(data);
      data = (data as List).map((e) => Subscription.fromJson(e)).toList();

      print('subscribedData: $data');

      //Save subject in local storage
      setSubscription(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
      // Navigator.push(
      //     _context,
      //     MaterialPageRoute(
      //         builder: (context) => AppLayout(
      //               index: 4,
      //             )));
      // showFlush(_context, ex.toString(), primaryColor);
    }
  }

  Future<Transactions> getTransactions() async {
    //initialize childIndex and users
    ChildIndex childIndex = SubjectProvider.subject(_context).index;
    List<Users> children = AuthProvider.auth(_context).users;
    MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;

    //get transactions
    try {
      var data = await _helper.getTransactions(
          _context,
          children != null
              ? children[childIndex?.index ?? 0].id
              : mainChildUser.id,
          AuthProvider.auth(_context).token);

      data = Transactions.fromJson(data);

      // data = (data as List).map((e) => Transactions.fromJson(e)).toList();

      //Save transactions in local storage
      setTransactions(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
    }
  }

  Future<List<AllSubscriptions>> getAllSubscription() async {
    //get all subscriptions
    try {
      var data = await _helper.getAllSubscriptions(
          _context, AuthProvider.auth(_context).token);

      print('subscribedData: $data');
      data = (data as List).map((e) => AllSubscriptions.fromJson(e)).toList();

      //Save subject in local storage
      setAllSubscription(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
    }
  }

  //add Subscription
  Future<dynamic> addSubscription(String subId, String type, String childId,
      [String cardId]) async {
    // add a subscription

    try {
      print('token:${AuthProvider.auth(_context).token}');
      var data = await _helper.addSubscription(subId, childId, type,
          AuthProvider.auth(_context).token, _context, cardId);
      return data;
    } catch (ex) {
      print('ex:$ex');
      showFlush(
          _context, toBeginningOfSentenceCase(ex.toString()), primaryColor);
    }
  }

  //toggle Subscription
  Future<dynamic> toggleSubscription(String subId, String type) async {
    // toggle a subscription

    try {
      var data = await _helper.toggleSubscription(
          subId, type, AuthProvider.auth(_context).token, _context);

      print('data:$data');
      if (data != null) {
        showFlush(
            _context, 'Successfully changed subscription type', primaryColor);
      }
    } catch (ex) {
      print('ex:$ex');
      showFlush(
          _context, toBeginningOfSentenceCase(ex.toString()), primaryColor);
    }
  }

  //add Subscription
  Future<dynamic> verifySubscription(String id, String ref) async {
    // add a subscription
    try {
      var data = await _helper.verifySubscription(
          id, ref, _context, AuthProvider.auth(_context).token);
      return data;
    } catch (ex) {
      print('ex:$ex');
      AuthProvider.auth(_context).setIsLoading(false);
    }
  }

  static SubscriptionProvider subscribe(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<SubscriptionProvider>(context, listen: listen);
  }
}
