import 'package:cliqlite/helper/network_helper.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
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

  Future<List<dynamic>> getQuiz(
      {String topicId, BuildContext buildContext}) async {
    //Get quiz
    try {
      var data = await _helper.getQuiz(
          _context, topicId, AuthProvider.auth(_context).token);
      print('data:$data');
      return data;
    } catch (ex) {
      showFlush(buildContext, 'No Quiz For This Subject', primaryColor);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushNamed(buildContext, AppLayout.id);
      });
      print('ex:$ex');
    }
  }

  Future<dynamic> submitQuiz({int score, String quizId}) async {
    //Child Index
    ChildIndex childIndex = SubjectProvider.subject(_context).index;

    //Get All users
    List<Users> users = AuthProvider.auth(_context).users;

    //Get Child User
    MainChildUser mainChildUser = AuthProvider.auth(_context).mainChildUser;

    //Get quiz
    try {
      var data = await _helper.submitQuiz(
          score,
          users != null ? users[childIndex?.index ?? 0].id : mainChildUser.id,
          quizId,
          AuthProvider.auth(_context).token,
          _context);
      return data['data'];
    } catch (ex) {
      showFlush(_context, ex.toString(), primaryColor);
      print('ex:$ex');
    }
  }

  static QuizProvider quizProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<QuizProvider>(context, listen: listen);
  }
}
