import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class VideoProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();
  static BuildContext _context;

  List<Video> _videos;

  List<Video> get videos => _videos;

  setVideo(List<Video> videos) => _videos = videos;

  Future<List<Video>> getVideos() async {
    //Get videos
    var data =
        await _helper.getVideo(_context, AuthProvider.auth(_context).token);

    print('Videos:$data');
    data = (data as List).map((e) => Video.fromJson(e)).toList();

    //Save Topics in local storage
    setVideo(data);
    _hiveRepository.add<List<Video>>(name: kVideo, key: 'video', item: data);

    return data;
  }

  Future<List<Video>> getTopicVideos(String topicID) async {
    //Get videos
    var data = await _helper.getTopicVideos(
        topicID, _context, AuthProvider.auth(_context).token);

    print('Video Topic Data:$data');
    data = (data as List).map((e) => Video.fromJson(e)).toList();

    return data;
  }

  Future<List<Video>> getVideosBySearch({String description}) async {
    //search for subjects
    var data = await _helper.getVideoBySearch(
        _context, description, AuthProvider.auth(_context).token);

    data = (data as List).map((e) => Video.fromJson(e)).toList();

    return data;
  }

  static VideoProvider video(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<VideoProvider>(context, listen: listen);
  }
}
