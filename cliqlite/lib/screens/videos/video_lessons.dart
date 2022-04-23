import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
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

  Widget videoLessons() {
    List<Topic> _topic = TopicProvider.topic(context).topics;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              BackArrow(
                text: 'Video lessons',
                onTap: () => Navigator.pushNamed(context, AppLayout.id),
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
                                      Text(
                                        _topic[0].subject.name,
                                        style: heading18,
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
                                  primaryColor: Color(int.parse(
                                      '0XFF${_topic[index].primaryColor}')),
                                  secondaryColor: Color(int.parse(
                                      '0XFF${_topic[index].secondaryColor}')),
                                  widget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          child: SwipeChild(
                                            height: 120,
                                            subject: _topic[index].subject.name,
                                            time:
                                                '${_topic[0].video.duration} mins',
                                            slug: _topic[index].icon,
                                            topic: toBeginningOfSentenceCase(
                                                _topic[index]
                                                    .name
                                                    .toLowerCase()),
                                          ),
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoFullScreen(
                                                        topic: _topic[index],
                                                      ))))
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
