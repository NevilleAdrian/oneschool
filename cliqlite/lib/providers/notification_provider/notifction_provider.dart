import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/feedback/feedback.dart';
import 'package:cliqlite/models/notification_model/notification_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;

  List<Notifications> _notification;
  List<Feedbacks> _feedback;

  List<Notifications> get notification => _notification;
  List<Feedbacks> get feedback => _feedback;

  setNotification(List<Notifications> notification) =>
      _notification = notification;
  setFeedback(List<Feedbacks> feedback) => _feedback = feedback;

  Future<List<Notifications>> getNotification() async {
    //Get Notifications
    try {
      var data = await _helper.getNotification(
          _context, AuthProvider.auth(_context).token);

      print('notifyy:$data');

      data = (data as List).map((e) => Notifications.fromJson(e)).toList();

      //Save Topics in local storage
      setNotification(data);

      return data;
    } catch (ex) {
      print('ex:$ex');
    }
  }

  Future<List<Feedbacks>> getFeedBack() async {
    //Get Feedback
    try {
      var data = await _helper.getFeedback(
          _context, AuthProvider.auth(_context).token);

      print('feedyyy:$data');

      data = (data as List).map((e) => Feedbacks.fromJson(e)).toList();

      //Save Feedback in local storage
      setFeedback(data);
      return data;
    } catch (ex) {
      print('ex:$ex');
    }
  }

  static NotificationProvider notify(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<NotificationProvider>(context, listen: listen);
  }
}
