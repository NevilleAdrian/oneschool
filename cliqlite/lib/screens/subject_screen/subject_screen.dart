import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/recent_topics/recent_topics.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/make_subscription.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/videos/topic_videos.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectScreen extends StatefulWidget {
  static String id = 'subject';
  SubjectScreen({this.text, this.route, this.subjectId, this.topic});

  final String text;
  final String route;
  final String subjectId;
  final List<RecentTopic> topic;

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  Future<List<Topic>> futureTopics;

  Future<List<Topic>> futureTask() async {
    //Initialize provider
    TopicProvider topic = TopicProvider.topic(context);
    AuthProvider auth = AuthProvider.auth(context);
    SubjectProvider subject = SubjectProvider.subject(context);
    ChildIndex childIndex = subject.index;

    //Make call to get topics
    var result = await topic.getTopics(
        subjectId: widget.subjectId,
        childId: auth.user.role != 'child'
            ? auth.users[childIndex?.index ?? 0]?.id
            : auth.mainChildUser?.id);

    setState(() {});

    print('result:${result.map((e) => e.toJson())}');
    //Return future value
    return Future.value(result);
  }

  Widget subjectScreen(List<Topic> topics) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    print('topics: $topics');
    return SafeArea(
      child: Padding(
        padding: defaultVHPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackArrow(
                onTap: () => widget.route == 'home'
                    ? Navigator.pushNamed(context, AppLayout.id)
                    : Navigator.pushNamed(context, SearchScreen.id),
                text: '',
              ),
              kLargeHeight,
              Text(
                widget.text ?? 'Subject Name',
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: theme.status ? secondaryColor : primaryColor),
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              route: 'topics',
                            ))),
                child: SearchBox(
                  type: 'route',
                  padding: EdgeInsets.zero,
                  placeholder: 'Search for Topic',
                ),
              ),
              kLargeHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Topic',
                    style: theme.status
                        ? textLightBlack.copyWith(color: whiteColor)
                        : textLightBlack,
                  ),
                  kSmallHeight,
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 30),
                  //   child: ListView.separated(
                  //       separatorBuilder: (context, int) => SizedBox(
                  //             height: 15,
                  //           ),
                  //       physics: NeverScrollableScrollPhysics(),
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: topics.length,
                  //       shrinkWrap: true,
                  //       itemBuilder: (context, index) {
                  //         return Pills(
                  //           text: topics[index].title,
                  //           tutor: topics[index].tutor,
                  //           topicId: topics[index].id,
                  //           subjectId: widget.subjectId,
                  //           video: topics[index].videos,
                  //         );
                  //       }),
                  // )
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Topic> topics = TopicProvider.topic(context).topics;

    return BackgroundImage(
      child: FutureHelper(
          task: futureTopics,
          loader: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [circularProgressIndicator()],
          ),
          builder: (context, _) => subjectScreen(topics)),
    );
  }
}

class Pills extends StatelessWidget {
  const Pills(
      {this.text,
      this.subText,
      this.topicId,
      this.subjectId,
      this.tutor,
      this.video});

  final String text;
  final String subText;
  final String topicId;
  final String subjectId;
  final TopicTutor tutor;
  final List<dynamic> video;

  @override
  Widget build(BuildContext context) {
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

    bool subscribed = users != null
        ? users[childIndex?.index ?? 0].isSubscribed
        : mainChildUser.isSubscribed;

    onTapVideo() async {
      if (subscribed) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TopicVideos(
                      topicID: topicId,
                      name: text,
                      subscribed: subscribed,
                      subjectId: subjectId,
                    )));
      } else {
        Navigator.pushNamed(context, MakeSubscription.id);
      }
    }

    return InkWell(
      onTap: () => onTapVideo(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.3,
              blurRadius: 9,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/item-image.png',
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                padding: defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: textLightBlack,
                    ),
                    kVerySmallHeight,
                    Text(
                      '${video.length} video${video.isEmpty ? '' : 's'}',
                      style: textLightBlack.copyWith(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    kSmallHeight,
                    Text(
                      'Taught by ${tutor.fullname}',
                      style: textLightBlack.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: lightSecondaryColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
