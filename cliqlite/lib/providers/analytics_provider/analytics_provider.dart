import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/analytics/analytics_subject/analytics_subject.dart';
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AnalyticsProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;
  HiveRepository _hiveRepository = HiveRepository();

  List<AnalyticSubject> _subject = [];
  AnalyticTopic _topic;

  List<AnalyticSubject> get subject => _subject;
  AnalyticTopic get topic => _topic;

  setSubject(List<AnalyticSubject> subject) => _subject = subject;
  setTopic(AnalyticTopic topic) => _topic = topic;

  Future<List<AnalyticSubject>> getSubject() async {
    //ChildIndex and Users
    ChildIndex childIndex = SubjectProvider.subject(_context).index;
    List<Users> users = AuthProvider.auth(_context).users;
    MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;

    //Get Subject
    try {
      var data = await _helper.getAnalyticsSubject(
          _context,
          users != null ? users[childIndex?.index ?? 0].id : mainChildUser.id,
          AuthProvider.auth(_context).token);

      print('Subject:$data');

      data = (data as List).map((e) => AnalyticSubject.fromJson(e)).toList();

      //Save Topics in local storage
      setSubject(data);
      _hiveRepository.add<List<AnalyticSubject>>(
          name: kAnalyticsSubject, key: 'analyticsSubject', item: data);

      return data;
    } catch (ex) {
      print('ex:$ex');
    }
  }

  Future<AnalyticTopic> getTopic() async {
    try {
      //ChildIndex and Users
      ChildIndex childIndex = SubjectProvider.subject(_context).index;
      List<Users> users = AuthProvider.auth(_context).users;
      MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;

      //Get Topics
      var data = await _helper.getAnalyticsTopic(
          _context,
          users != null ? users[childIndex?.index ?? 0].id : mainChildUser.id,
          AuthProvider.auth(_context).token);

      print('Topics:$data');

      if (data?.isEmpty ?? true) {
        data = AnalyticTopic.fromJson(analyticData);
      } else {
        data = AnalyticTopic.fromJson(data);
      }

      //Save Topics in local storage
      setTopic(data);
      _hiveRepository.add<AnalyticTopic>(
          name: kAnalyticsTopic, key: 'analyticsTopic', item: data);

      return data;
    } catch (ex) {
      print('ex:$ex');
    }
  }

  static AnalyticsProvider analytics(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<AnalyticsProvider>(context, listen: listen);
  }
}
