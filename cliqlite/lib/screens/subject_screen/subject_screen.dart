import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectScreen extends StatefulWidget {
  static String id = 'subject';
  SubjectScreen({this.text, this.route, this.subjectId});

  final String text;
  final String route;
  final String subjectId;

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  Future<List<Topic>> futureTopics;

  Future<List<Topic>> futureTask() async {
    //Initialize provider
    TopicProvider topic = TopicProvider.topic(context);

    //Make call to get topics
    var result = await topic.getTopics(
      subjectId: widget.subjectId,
    );

    setState(() {});

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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListView.separated(
                        separatorBuilder: (context, int) => SizedBox(
                              height: 15,
                            ),
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: topics.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Pills(
                            text: topics[index].title,
                            topicId: topics[index].id,
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
  const Pills({this.text, this.subText, this.topicId});

  final String text;
  final String subText;
  final String topicId;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      shadowColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizScreen(
                        topicId: topicId,
                      ))),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
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
                      kSmallHeight,
                      Text(
                        'Take Quiz',
                        style: smallPrimaryColor.copyWith(
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
