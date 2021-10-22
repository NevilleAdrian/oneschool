import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  String _background = 'assets/images/bg.png';
  String get background => _background;

  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeProvider({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool _status = false;
  bool get status => _status;

  static BuildContext _context;

  setStatus(bool status) {
    _status = status;
    notifyListeners();
    print('_background: $_background');
  }

  setBackground(String background) {
    _background = background;
    notifyListeners();

    print('_background: $_background');
  }

  static ThemeProvider themeProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<ThemeProvider>(context, listen: listen);
  }
}
