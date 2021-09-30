import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class QuizProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;

  static BuildContext _context;

  setNumber(int myNumber) {
    _number = myNumber;
    notifyListeners();

    print('numbzzz: $_number');
  }

  static QuizProvider quizProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<QuizProvider>(context, listen: listen);
  }
}
