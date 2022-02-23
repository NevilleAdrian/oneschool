import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/recent_topics/recent_topics.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TopicProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();
  static BuildContext _context;

  List<Topic> _topics;
  List<RecentTopic> _recentTopics;

  List<Topic> get topics => _topics;

  List<RecentTopic> get recentTopics => _recentTopics;

  setTopic(List<Topic> topics) => _topics = topics;
  setRecentTopic(List<RecentTopic> recentTopics) =>
      _recentTopics = recentTopics;

  Future<List<Topic>> getTopics({String subjectId, String childId}) async {
    //Get topics
    try {
      var data = await _helper.getTopic(
          _context, subjectId, childId, AuthProvider.auth(_context).token);

      print('data:$data');

      data = (data as List).map((e) => Topic.fromJson(e)).toList();
      print('topic:$data');

      //Save Topics in local storage
      setTopic(data);
      _hiveRepository.add<List<Topic>>(name: kTopic, key: 'topic', item: data);

      return data;
    } catch (ex) {
      print('ex: $ex');
    }
  }

  Future<dynamic> submitFeedback(
      {String topicId, String text, double rating}) async {
    //Get topics
    var data = await _helper.submitFeedback(
        topicId, text, rating, AuthProvider.auth(_context).token, _context);

    return data;
  }

  Future<List<RecentTopic>> getRecentTopics({String childId}) async {
    //Get recent topics
    print('chilid:$childId');
    var data = await _helper.getRecentTopic(
        _context, childId, AuthProvider.auth(_context).token);

    print('recent:$data');
    data = (data as List).map((e) => RecentTopic.fromJson(e)).toList();

    // //Save Topics in local storage
    setRecentTopic(data);
    _hiveRepository.add<List<RecentTopic>>(
        name: kRecent, key: 'recentTopics', item: data);

    return data;
  }

  Future<List<Topic>> getTopicsBySearch({String description}) async {
    //search for subjects
    var data = await _helper.getTopicBySearch(
        _context, description, AuthProvider.auth(_context).token);

    data = (data as List).map((e) => Topic.fromJson(e)).toList();

    print('DATA:$data');
    return data;
  }

  static TopicProvider topic(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<TopicProvider>(context, listen: listen);
  }
}
