import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/videos/video_lessons.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/x_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'search';
  final String route;
  SearchScreen({this.route});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Subject>> futureSubject;
  List<Subject> subject;

  TextEditingController _nameController = TextEditingController();
  List<dynamic> filteredSearch = [];

  // Future<List<Topic>> futureTopicTask() async {
  //   List<Topic> result =
  //       await TopicProvider.topic(context).getTopicsBySearch(description: '');
  //   print('topicResult: $result');
  //   setState(() {
  //     topic = result;
  //   });
  //   return Future.value(result);
  // }

  Future<List<Subject>> futureSubjectTask() async {
    List<Subject> result = await SubjectProvider.subject(context)
        .getSubjectsBySearch(description: '');
    print('result: $result');
    setState(() {
      subject = result;
    });
    return Future.value(result);
  }

  // Future<List<Video>> futureVideoTask() async {
  //   List<Video> result =
  //       await VideoProvider.video(context).getVideosBySearch(description: '');
  //   print('result: $result');
  //   setState(() {
  //     video = result;
  //   });
  //   return Future.value(result);
  // }

  onSearch() async {
    print('text is ${_nameController.text}');
    List<Subject> result;
    if (_nameController.text.length > 1) {
      result = await SubjectProvider.subject(context)
          .getSubjectsBySearch(description: _nameController.text.toLowerCase());
    } else {
      result = await SubjectProvider.subject(context)
          .getSubjectsBySearch(description: '');
    }
    setState(() {
      subject = result;
      print('subject');
    });
  }

  @override
  void initState() {
    filteredSearch = data;
    _nameController.addListener(onSearch);
    futureSubject = futureSubjectTask();
    // futureTopic = futureTopicTask();
    // futureVideo = futureVideoTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return BackgroundImage(
        child: SafeArea(
      child: FutureHelper(
        task: futureSubject,
        loader: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        builder: (context, _) => Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              XButton(
                onTap: () => Navigator.pushNamed(context, AppLayout.id),
                color: greyColor,
              ),
              SizedBox(height: 15),
              SearchBox(
                type: 'search',
                size: 5.0,
                placeholder: 'Search for Subject',
                nameController: _nameController,
              ),
              kLargeHeight,
              Expanded(
                child: Padding(
                  padding: defaultPadding.copyWith(left: 65),
                  child: ListView.separated(
                      separatorBuilder: (context, int) => SizedBox(
                            height: 35,
                          ),
                      scrollDirection: Axis.vertical,
                      itemCount: subject.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoLessons(
                                        subId: subject[index].id,
                                      ))),
                          child: Text(
                            toBeginningOfSentenceCase(subject[index].name),
                            style: textExtraLightBlack.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.status ? whiteColor : blackColor),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
