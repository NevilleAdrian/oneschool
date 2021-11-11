import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/livestream_model/livestream_model.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LiveStreamProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  static BuildContext _context;
  HiveRepository _hiveRepository = HiveRepository();

  List<LiveStream> _live;

  List<LiveStream> get live => _live;

  setLiveStream(List<LiveStream> live) => _live = live;

  Future<List<LiveStream>> getLiveStream() async {
    //ChildIndex and Users
    ChildIndex childIndex = SubjectProvider.subject(_context).index;
    List<Users> users = AuthProvider.auth(_context).users;
    MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;

    //Get Subject
    try {
      var data = await _helper.getLiveStream(
          _context,
          users != null
              ? users[childIndex?.index ?? 0].grade
              : mainChildUser.grade,
          AuthProvider.auth(_context).token);

      print('stream:$data');

      data = (data as List).map((e) => LiveStream.fromJson(e)).toList();

      //Save LiveStream in local storage
      setLiveStream(data);
      _hiveRepository.add<List<LiveStream>>(
          name: kLiveStream, key: 'liveStream', item: data);

      return data;
    } catch (ex) {
      print('ex:$ex');
    }
  }

  static LiveStreamProvider liveStream(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<LiveStreamProvider>(context, listen: listen);
  }
}
