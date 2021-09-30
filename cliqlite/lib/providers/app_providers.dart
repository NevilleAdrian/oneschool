import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<ChildProvider>(create: (_) => ChildProvider()),
  ChangeNotifierProvider<QuizProvider>(create: (context) => QuizProvider()),
];
