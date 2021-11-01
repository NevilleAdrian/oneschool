import 'package:cliqlite/helper/network_helper.dart';
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

  List<Topic> get topics => _topics;

  setTopic(List<Topic> topics) => _topics = topics;

  Future<List<Topic>> getTopics({String subjectId}) async {
    //Get topics
    var data = await _helper.getTopic(_context, subjectId, AuthProvider.auth(_context).token);

    print('topicsss:$data');
    data = (data as List).map((e) => Topic.fromJson(e)).toList();

    //Save Topics in local storage
    setTopic(data);
    _hiveRepository.add<List<Topic>>(name: kTopic, key: 'topic', item: data);

    return data;
  }

  Future<List<Topic>> getTopicsBySearch({String description}) async {
    //search for subjects
    var data = await _helper.getTopicBySearch(
        _context, description, AuthProvider.auth(_context).token);

    data = (data as List).map((e) => Topic.fromJson(e)).toList();

    return data;
  }

  static TopicProvider topic(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<TopicProvider>(context, listen: listen);
  }
}
