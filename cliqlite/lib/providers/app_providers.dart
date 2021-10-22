import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<ChildProvider>(create: (_) => ChildProvider()),
  ChangeNotifierProvider<QuizProvider>(create: (context) => QuizProvider()),
  ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
];
