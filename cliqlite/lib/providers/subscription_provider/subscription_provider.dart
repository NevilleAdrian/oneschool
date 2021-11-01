import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;

  Subscription _subscription;

  Subscription get subscription => _subscription;

  setSubscription(Subscription subscription) => _subscription = subscription;

  Future<Subscription> getSubscription() async {
    //initialize childIndex and users
    ChildIndex childIndex = SubjectProvider.subject(_context).index;
    List<Users> children = AuthProvider.auth(_context).users;

    print('id:${children[childIndex.index ?? 0].id}');
    //get subscription
    try {
      var data = await _helper.getSubscription(
          _context,
          children[childIndex.index ?? 0].id,
          AuthProvider.auth(_context).token);

      print('subscribedData: $data');
      data = Subscription.fromJson(data);

      //Save subject in local storage
      setSubscription(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
      Navigator.push(
          _context,
          MaterialPageRoute(
              builder: (context) => AppLayout(
                    index: 4,
                  )));
      showFlush(_context, ex.toString(), primaryColor);
    }
  }

  Future<Subscription> getAllSubscription() async {
    //get all subscriptions
    try {
      var data = await _helper.getAllSubscriptions(
          _context, AuthProvider.auth(_context).token);

      print('subscribedData: $data');
      data = Subscription.fromJson(data);

      //Save subject in local storage
      setSubscription(data);
      return data;
    } catch (ex) {
      print('ex: $ex');
      Navigator.push(
          _context,
          MaterialPageRoute(
              builder: (context) => AppLayout(
                    index: 4,
                  )));
      showFlush(_context, ex.toString(), primaryColor);
    }
  }

  static SubscriptionProvider subscribe(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<SubscriptionProvider>(context, listen: listen);
  }
}
