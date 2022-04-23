import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/screens/videos/video_lessons.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QuizResult extends StatefulWidget {
  static String id = 'result';

  QuizResult({this.score, this.aggregate, this.topicId, this.quizId});

  final int score;
  final int aggregate;
  final String topicId;
  final String quizId;
  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  newQuiz() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoLessons(
                // subId: ,
                )));
  }

  retakeQuiz() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizScreen(
                  topicId: widget.topicId,
                )));
  }

  @override
  void initState() {
    print('topicID:${widget.topicId}');
    super.initState();
  }

  submitQuiz({bool type}) async {
    // if (type) {
    //   //Route to home page
    //   newQuiz();
    // } else {
    //   //Take Quiz again
    //   retakeQuiz();
    // }
    // Set Loader
    setState(() {
      AuthProvider.auth(context).setIsLoading(true);
    });
    try {
      //Submit Quiz
      var result = await QuizProvider.quizProvider(context)
          .submitQuiz(score: widget.score, quizId: widget.quizId);

      if (result != null) {
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
        if (type) {
          //Route to home page
          newQuiz();
        } else {
          //Take Quiz again
          retakeQuiz();
        }
      }
    } catch (ex) {
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
      showFlush(context, ex.toString(), primaryColor);
    }
  }

  int calculateScore() {
    return ((widget.score / widget.aggregate) * 100).ceil();
  }

  bool showPass() {
    if (calculateScore() > 50) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    AuthProvider auth = AuthProvider.auth(context);
    List<Topic> _topic = TopicProvider.topic(context).topics;

    return BackgroundImage(
      child: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 7,
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: defaultVHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/${showPass() ? 'pass' : 'fail'}.png'),
                  kSmallHeight,
                  Text(
                    showPass() ? 'Congratulations' : 'You can do better!',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: showPass() ? primaryColor : redColor),
                  ),
                  kSmallHeight,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: showPass() ? secondaryColor : lightRedColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Your score',
                          textAlign: TextAlign.center,
                          style: textStyleSmall.copyWith(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w700,
                              color: showPass() ? primaryColor : redColor),
                        ),
                        kSmallHeight,
                        Text(
                          '${calculateScore()}%',
                          textAlign: TextAlign.center,
                          style: smallAccentColor.copyWith(
                              fontSize: 36.0,
                              color: showPass() ? accentColor : redColor),
                        )
                      ],
                    ),
                  ),
                  kSmallHeight,
                  Padding(
                    padding: defaultPadding,
                    child: RichText(
                      text: TextSpan(
                          text: 'Summary: ',
                          style: headingSmallGreyColor.copyWith(
                              color: greyishColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'You answered ${widget.score} question(s) correctly out of ${widget.aggregate} attempted questions',
                              style:
                                  headingSmallGreyColor.copyWith(fontSize: 14),
                            )
                          ]),
                    ),
                  ),
                  kLargeHeight,
                  GreenButton(
                    submit: () => submitQuiz(type: false),
                    color: primaryColor,
                    name: 'Take new quiz',
                    height: 45,
                    buttonColor: secondaryColor,
                    loader: false,
                  ),
                  kSmallHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BorderButton(
                        onTap: () => submitQuiz(type: true),
                        height: 15,
                        text: 'Return to lesson',
                      ),
                    ],
                  ),
                  kLargeHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextBox(
                        text: 'More lessons to help you',
                      ),
                    ],
                  ),
                  kSmallHeight,
                  _topic == null
                      ? Container()
                      : Container(
                          height: 140,
                          child: ListView.separated(
                              separatorBuilder: (context, _) => kSmallWidth,
                              itemCount: _topic?.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SwipeItems(
                                  borderHeight: 80,
                                  borderWidth: 90,
                                  primaryColor: Color(int.parse(
                                      '0XFF${_topic[index].primaryColor}')),
                                  secondaryColor: Color(int.parse(
                                      '0XFF${_topic[index].secondaryColor}')),
                                  widget: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            child: SwipeChild(
                                              height: 120,
                                              subject:
                                                  _topic[index].subject.name,
                                              time:
                                                  '${DateFormat('mm').format(_topic[0].createdAt)} mins',
                                              slug: _topic[index].icon,
                                              topic: _topic[index].name,
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
                                  ),
                                );
                              }),
                        )

                  // Container(
                  //   height: 140,
                  //   child: ListView.separated(
                  //       separatorBuilder: (context, _) => kSmallWidth,
                  //       itemCount: 4,
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         return InkWell(
                  //           onTap: () => submitQuiz(type: true),
                  //           child: SwipeItems(
                  //             widget: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [SwipeChild()],
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
