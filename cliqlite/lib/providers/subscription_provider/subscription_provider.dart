import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subscription_model/all_subscriptions/all_subscriptions.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/models/transactions/transactions.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SubscriptionProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;

  List<Subscription> _subscription;
  List<AllSubscriptions> _allSubscription;
  List<Transactions> _transactions;

  List<Subscription> get subscription => _subscription;
  List<AllSubscriptions> get allSubscription => _allSubscription;
  List<Transactions> get transactions => _transactions;

  setSubscription(List<Subscription> subscription) =>
      _subscription = subscription;
  setAllSubscription(List<AllSubscriptions> allSubscription) =>
      _allSubscription = allSubscription;
  setTransactions(List<Transactions> transactions) =>
      _transactions = transactions;

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

  Future<List<Transactions>> getTransactions() async {
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

      print('transactionData: $data');
      data = (data as List).map((e) => Transactions.fromJson(e)).toList();

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
  Future<dynamic> addSubscription(String subId, String childId) async {
    // add a subscription

    try {
      var data = await _helper.addSubscription(
          subId, childId, AuthProvider.auth(_context).token, _context);
      return data;
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
