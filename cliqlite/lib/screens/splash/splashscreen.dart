import 'package:cliqlite/models/analytics/analytics_subject/analytics_subject.dart';
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:cliqlite/models/app_model/app_model.dart';
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
import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/livestream_provider/livestream_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/onboarding/onboarding.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //Initialize hive repository
  HiveRepository _hiveRepository = HiveRepository();

  //Initialize animation controller
  AnimationController controller;

  //Initialize animation
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _prepareAppState();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  _prepareAppState() async {
    await HiveRepository.openHives([
      kUser,
      kFirst,
      kGrades,
      kUsers,
      kAppDataName,
      kSubject,
      kSingleGrade,
      kTopic,
      kVideo,
      kIndex,
      kAnalyticsSubject,
      kAnalyticsTopic,
      kLiveStream,
      kMainUser,
      kQuizActive,
      kRecent
    ]);
    AppModel appModel;
    AuthUser user;
    FirstTime first;
    List<Grades> grades;
    List<Users> users;
    List<Subject> subject;
    Grade singleGrade;
    List<Topic> topic;
    List<Video> video;
    ChildIndex index;
    List<AnalyticSubject> analyticsSubject;
    AnalyticTopic analyticsTopic;
    List<LiveStream> liveStream;
    MainChildUser mainUser;
    QuizActive quizActive;
    List<RecentTopic> recentTopic;

    try {
      user = _hiveRepository.get<AuthUser>(key: 'user', name: kUser);
      appModel =
          _hiveRepository.get<AppModel>(key: 'appModel', name: kAppDataName);
      users = _hiveRepository.get<List<Users>>(key: 'users', name: kUsers);
      grades = _hiveRepository.get<List<Grades>>(key: 'grades', name: kGrades);
      subject =
          _hiveRepository.get<List<Subject>>(key: 'subject', name: kSubject);
      topic = _hiveRepository.get<List<Topic>>(key: 'topic', name: kTopic);
      video = _hiveRepository.get<List<Video>>(key: 'video', name: kVideo);
      analyticsSubject = _hiveRepository.get<List<AnalyticSubject>>(
          key: 'analyticsSubject', name: kAnalyticsSubject);
      analyticsTopic = _hiveRepository.get<AnalyticTopic>(
          key: 'analyticsTopic', name: kAnalyticsTopic);
      liveStream = _hiveRepository.get<List<LiveStream>>(
          key: 'liveStream', name: kLiveStream);
      mainUser =
          _hiveRepository.get<MainChildUser>(key: 'mainUser', name: kMainUser);
      recentTopic = _hiveRepository.get<List<RecentTopic>>(
          key: 'recentTopics', name: kRecent);
    } catch (ex) {
      print(ex);
    }
    first = _hiveRepository.get<FirstTime>(key: 'first', name: kFirst);
    singleGrade =
        _hiveRepository.get<Grade>(key: 'singleGrade', name: kSingleGrade);
    AuthProvider.auth(context).setFirst(first);
    index = _hiveRepository.get<ChildIndex>(key: 'index', name: kIndex);
    quizActive =
        _hiveRepository.get<QuizActive>(key: 'quizActive', name: kQuizActive);

    print('index:$index');
    if (first == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OnboardingScreen.id, (Route<dynamic> route) => false);
    } else {
      if (user == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.id, (Route<dynamic> route) => false);
      } else {
        AuthProvider.auth(context).setUser(user);
        AuthProvider.auth(context).setGrades(grades);
        AuthProvider.auth(context).setToken(appModel.token);
        AuthProvider.auth(context).setUsers(users);
        SubjectProvider.subject(context).setSubject(subject);
        SubjectProvider.subject(context).setGrade(singleGrade);
        TopicProvider.topic(context).setTopic(topic);
        VideoProvider.video(context).setVideo(video);
        SubjectProvider.subject(context).setIndex(index);
        AnalyticsProvider.analytics(context).setSubject(analyticsSubject);
        AnalyticsProvider.analytics(context).setTopic(analyticsTopic);
        LiveStreamProvider.liveStream(context).setLiveStream(liveStream);
        AuthProvider.auth(context).setMainChildUser(mainUser);
        QuizProvider.quizProvider(context).setQuizActive(quizActive);
        TopicProvider.topic(context).setRecentTopic(recentTopic);
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppLayout.id, (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: controller.value * 200,
          ),
          kSmallWidth,
          SvgPicture.asset('assets/images/svg/text.svg'),
        ],
      )),
    );
  }
}
