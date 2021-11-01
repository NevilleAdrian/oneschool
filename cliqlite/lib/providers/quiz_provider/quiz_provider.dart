import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class QuizProvider extends ChangeNotifier {
  NetworkHelper _helper = NetworkHelper();
  HiveRepository _hiveRepository = HiveRepository();
  int _number = 0;
  List<dynamic> _quiz;

  int get number => _number;
  List<dynamic> get quiz => _quiz;

  static BuildContext _context;

  setNumber(int myNumber) {
    _number = myNumber;
    notifyListeners();
  }

  setQuiz(List<dynamic> quiz) => _quiz = quiz;

  Future<List<dynamic>> getQuiz({String topicId}) async {
    //Get quiz
    var data = await _helper.getQuiz(
        _context, topicId, AuthProvider.auth(_context).token);

    // data = (data as List).map((e) => Quiz.fromJson(e)).toList();
    //
    // //Save Quiz in local storage
    // setQuiz(data);

    return data;
  }

  static QuizProvider quizProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<QuizProvider>(context, listen: listen);
  }
}
