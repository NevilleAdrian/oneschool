import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/livestream_provider/livestream_provider.dart';
import 'package:cliqlite/providers/notification_provider/notifction_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/providers/support_provider/support_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<ChildProvider>(create: (_) => ChildProvider()),
  ChangeNotifierProvider<QuizProvider>(create: (context) => QuizProvider()),
  ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<SubjectProvider>(
      create: (context) => SubjectProvider()),
  ChangeNotifierProvider<TopicProvider>(create: (context) => TopicProvider()),
  ChangeNotifierProvider<VideoProvider>(create: (context) => VideoProvider()),
  ChangeNotifierProvider<SubscriptionProvider>(
      create: (context) => SubscriptionProvider()),
  ChangeNotifierProvider<SupportProvider>(
      create: (context) => SupportProvider()),
  ChangeNotifierProvider<VideoProvider>(create: (context) => VideoProvider()),
  ChangeNotifierProvider<NotificationProvider>(
      create: (context) => NotificationProvider()),
  ChangeNotifierProvider<AnalyticsProvider>(
      create: (context) => AnalyticsProvider()),
  ChangeNotifierProvider<LiveStreamProvider>(
      create: (context) => LiveStreamProvider())
];
