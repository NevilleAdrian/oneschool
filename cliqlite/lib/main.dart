import 'package:cliqlite/models/analytics/analytics_subject/analytics_subject.dart';
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:cliqlite/models/app_model/app_model.dart';
import 'package:cliqlite/models/recommended_video_model/recommended_model.dart';
import 'package:cliqlite/models/auth_model/auth_user/auth_user.dart';
import 'package:cliqlite/models/auth_model/first_time/first_time.dart';
import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/models/livestream_model/livestream_model.dart';
import 'package:cliqlite/models/quiz_active/quiz_active.dart';
import 'package:cliqlite/models/recent_topics/recent_topics.dart';
import 'package:cliqlite/models/subject/grade/grade.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/app_providers.dart';
import 'package:cliqlite/screens/account/account.dart';
import 'package:cliqlite/screens/account/feedback/feedback.dart';
import 'package:cliqlite/screens/account/support/support.dart';
import 'package:cliqlite/screens/analytics/view_details.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/auth/forgot_password.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/auth/registration.dart';
import 'package:cliqlite/screens/auth/verify_account.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/screens/home/check_back.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/home/make_subscription.dart';
import 'package:cliqlite/screens/home/my_points.dart';
import 'package:cliqlite/screens/home/profile_body.dart';
import 'package:cliqlite/screens/home/select_subject.dart';
import 'package:cliqlite/screens/live_tutor/live_video.dart';
import 'package:cliqlite/screens/onboarding/onboarding.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_result.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/splash/splashscreen.dart';
import 'package:cliqlite/screens/subject_screen/subject_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/screens/videos/video_lessons.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:provider/provider.dart';

void main() async {
  await _openHive();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(AuthUserAdapter());
  Hive.registerAdapter(FirstTimeAdapter());
  Hive.registerAdapter(GradesAdapter());
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(AppModelAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(GradeAdapter());
  Hive.registerAdapter(TopicAdapter());
  Hive.registerAdapter(VideoAdapter());
  Hive.registerAdapter(ChildIndexAdapter());
  Hive.registerAdapter(AnalyticSubjectAdapter());
  Hive.registerAdapter(AnalyticTopicAdapter());
  Hive.registerAdapter(LiveStreamAdapter());
  Hive.registerAdapter(MainChildUserAdapter());
  Hive.registerAdapter(QuizActiveAdapter());
  Hive.registerAdapter(RecentTopicAdapter());
  Hive.registerAdapter(RecommendedVideoAdapter());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        title: 'Oneschool Africa',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: lightTheme,
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          GetStarted.id: (context) => GetStarted(),
          OnboardingScreen.id: (context) => OnboardingScreen(),
          Registration.id: (context) => Registration(),
          ChildRegistration.id: (context) => ChildRegistration(),
          Login.id: (context) => Login(),
          ForgotPassword.id: (context) => ForgotPassword(),
          AppLayout.id: (context) => AppLayout(),
          Home.id: (context) => Home(),
          SearchScreen.id: (context) => SearchScreen(),
          SubjectScreen.id: (context) => SubjectScreen(),
          QuizScreen.id: (context) => QuizScreen(),
          QuizResult.id: (context) => QuizResult(),
          Account.id: (context) => Account(),
          Support.id: (context) => Support(),
          MakeSubscription.id: (context) => MakeSubscription(),
          FeedBackScreen.id: (context) => FeedBackScreen(),
          MyPoints.id: (context) => MyPoints(),
          CheckBack.id: (context) => CheckBack(),
          ProfileBody.id: (context) => ProfileBody(),
          ViewDetails.id: (context) => ViewDetails(),
          VideoLessons.id: (context) => VideoLessons(),
          VideoFullScreen.id: (context) => VideoFullScreen(),
          SelectSubject.id: (context) => SelectSubject(),
          VideoApp.id: (context) => VideoApp(),
          VerifyAccount.id: (context) => VerifyAccount(),
        },
      ),
    );
  }
}
