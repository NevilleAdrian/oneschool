import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/home/make_subscription.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VideoLessons extends StatefulWidget {
  static String id = "lessons";

  final String subId;

  const VideoLessons({Key key, this.subId}) : super(key: key);
  @override
  _VideoLessonsState createState() => _VideoLessonsState();
}

class _VideoLessonsState extends State<VideoLessons> {
  Future<List<Topic>> futureTopics;

  List<Topic> topic;

  Future<List<Topic>> futureTask() async {
    //Initialize provider
    TopicProvider _topic = TopicProvider.topic(context);
    AuthProvider auth = AuthProvider.auth(context);
    SubjectProvider subject = SubjectProvider.subject(context);
    ChildIndex childIndex = subject.index;

    var topicResult;

    //Make call to get topics
    try {
      topicResult = await _topic.getTopics(
          subjectId: widget.subId,
          childId: auth.user.role != 'child'
              ? auth.users[childIndex?.index ?? 0]?.id
              : auth.mainChildUser?.id);
      print('topicResults:$topicResult');
      //Return future value
      return Future.value(topicResult);
    } catch (ex) {}
    //Return future value
  }

  videoRoute(Topic topic) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoFullScreen(
                  topic: topic,
                )));
  }

  bool summerSchool({String plan, String type}) {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    print('plan: $plan');
    print('type: $type');
    // print(
    //     'plan-type: ${AuthProvider.auth(context).users[childIndex?.index ?? 0]?.planType}');
    String planType = AuthProvider.auth(context).user.role != 'child'
        ? AuthProvider.auth(context).users[childIndex?.index ?? 0]?.planType
        : AuthProvider.auth(context).mainChildUser?.planType;
    // print('child-users: ${AuthProvider.auth(context).users}');
    if (plan == 'free' || planType == type) {
      print('true');
      return true;
    } else {
      print('false');
      return false;
    }
  }

  Widget videoLessons() {
    List<Topic> _topic = TopicProvider.topic(context).topics;
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

    bool subscribed = users != null
        ? users[childIndex?.index ?? 0].isSubscribed
        : mainChildUser.isSubscribed;

    bool test =
        users != null ? users[childIndex?.index ?? 0].test : mainChildUser.test;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              BackArrow(
                text: 'Video lessons',
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     AppLayout.id, (Route<dynamic> route) => false),
                }
              ),
              kLargeHeight,
              _topic.isEmpty
                  ? Center(
                      child: Container(
                        child: Text('No Topic Available'),
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SwipeItems(
                              width: 115,
                              primaryColor: Color(
                                  int.parse('0XFF${_topic[0].primaryColor}')),
                              secondaryColor: Color(
                                  int.parse('0XFF${_topic[0].secondaryColor}')),
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FadeInImage(
                                    image: NetworkImage(_topic[0].icon),
                                    height: 45,
                                    placeholder:
                                        AssetImage('assets/images/dna.png'),
                                  ),
                                  kSmallHeight,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _topic[0].subject.name,
                                          style: heading18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            kSmallWidth,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _topic[0].subject.name,
                                  style: textStyleSmall.copyWith(
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('${_topic.length} Topics',
                                    style: headingSmallGreyColor.copyWith(
                                        fontSize: 14)),
                                kVerySmallHeight,
                                Text(
                                    'Total time: ${_topic[0].video.duration} min(s)',
                                    style: headingSmallGreyColor.copyWith(
                                        fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                        // kSmallHeight,
                        // GreenButton(
                        //   submit: () {
                        //     nextPage(context);
                        //   },
                        //   color: primaryColor,
                        //   name: 'Take Quiz',
                        //   buttonColor: secondaryColor,
                        //   loader: false,
                        // ),
                        kSmallHeight,
                        Divider(
                          thickness: 0.7,
                        ),
                        kSmallHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Topics',
                              style: textStyleSmall.copyWith(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            )
                          ],
                        ),
                        kSmallHeight,
                        Container(
                          child: ListView.separated(
                              separatorBuilder: (context, _) => kSmallHeight,
                              itemCount: _topic.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SwipeItems(
                                  borderHeight: 80,
                                  borderWidth: 90,
                                  primaryColor: summerSchool(
                                          plan: _topic[index].plan,
                                          type: _topic[index].type)
                                      // || AuthProvider.auth(context).users
                                      ? Color(int.parse(
                                          '0XFF${_topic[index].primaryColor}'))
                                      : primaryColor.withOpacity(0.3),
                                  secondaryColor: summerSchool(
                                          plan: _topic[index].plan,
                                          type: _topic[index].type)
                                      ? Color(int.parse(
                                          '0XFF${_topic[index].secondaryColor}'))
                                      : primaryColor.withOpacity(0.3),
                                  widget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          child: SwipeChild(
                                            height: 120,
                                            thumbnail:
                                                _topic[index].video.thumbnail,
                                            subject: _topic[index].subject.name,
                                            time:
                                                '${_topic[0].video.duration} mins',
                                            slug: _topic[index].icon,
                                            topic: toBeginningOfSentenceCase(
                                                _topic[index]
                                                    .name
                                                    .toLowerCase()),
                                          ),
                                          onTap: () {
                                            if (summerSchool(
                                                plan: _topic[index].plan,
                                                type: _topic[index].type)) {
                                              print('free');
                                              videoRoute(_topic[index]);
                                            } else {
                                              dialogBox(
                                                  context,
                                                  Container(
                                                    padding: defaultPadding,
                                                    height: 385,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      // crossAxisAlignment:
                                                      //     CrossAxisAlignment.stretch,
                                                      children: [
                                                        Text(
                                                          'Are you subscribed',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              smallAccentColor
                                                                  .copyWith(
                                                                      fontSize:
                                                                          18),
                                                        ),
                                                        kSmallHeight,
                                                        GreenButton(
                                                          name: 'Yes',
                                                          color: primaryColor,
                                                          buttonColor:
                                                              secondaryColor,
                                                          loader: false,
                                                          submit: () {
                                                            if (test) {
                                                              print('route');
                                                              videoRoute(_topic[
                                                                  index]);
                                                            } else {
                                                              if (subscribed) {
                                                                videoRoute(
                                                                    _topic[
                                                                        index]);
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                MakeSubscription()));
                                                              }
                                                            }
                                                          },
                                                        ),
                                                        kSmallHeight,
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            BorderButton(
                                                              text: 'No',
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () =>
                                                      Navigator.pop(context));
                                            }
                                          })
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    futureTopics = futureTask();
    print('subId: ${widget.subId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void nextPage(BuildContext context) {
      Navigator.pushNamed(context, QuizScreen.id);
    }

    List<Topic> _topic = TopicProvider.topic(context).topics;

    return BackgroundImage(
      child: FutureHelper(
          task: futureTopics,
          loader: _topic == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [circularProgressIndicator()],
                )
              : videoLessons(),
          noData: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('No data available')],
          ),
          builder: (context, _) => videoLessons()),
    );
  }
}
