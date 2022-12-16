import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreen extends StatefulWidget {
  static String id = 'fullscreen';

  VideoFullScreen({this.video, this.topic});
  final Video video;
  final Topic topic;

  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  // BetterPlayerController _betterPlayerController;
  Future<List<dynamic>> futureQuiz;
  List<dynamic> quizResult;
  FlickManager flickManager;

  Future<List<dynamic>> futureTask() async {
    //Initialize provider
    QuizProvider quiz = QuizProvider.quizProvider(context);
    // Make call to get quiz
    var result;

    try {
      result =
          await quiz.getQuiz(topicId: widget.topic.id, buildContext: context);
    } catch (ex) {}

    setState(() {
      quizResult = result;
    });

    print('quizresulttt: ${quizResult}');

    //Return future value
    return Future.value(result);
  }

  @override
  void initState() {
    futureQuiz = futureTask();

    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.network(widget
              .topic.video.url ??
          'https://res.cloudinary.com/obioflagos/video/upload/v1644839936/uploads/nm4umngsx7buam3ek07c.mp4'),
    );

    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     widget.topic.video.url ??
    //         'https://res.cloudinary.com/obioflagos/video/upload/v1644839936/uploads/nm4umngsx7buam3ek07c.mp4');
    // _betterPlayerController = BetterPlayerController(
    //     BetterPlayerConfiguration(aspectRatio: 12 / 10),
    //     betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void nextPage(BuildContext context, String id) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizScreen(
                    topicId: widget.topic.id,
                  )));
    }

    return BackgroundImage(
      child: FutureHelper<List<dynamic>>(
        task: futureQuiz,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        builder: (context, _) => SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallHeight,
                    BackArrow(
                      text: 'Video lessons',
                    ),
                    kSmallHeight,
                    Container(
                      padding: defaultPadding,
                      margin: defaultPadding,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black),
                      child: FlickVideoPlayer(flickManager: flickManager),
                    ),
                    kSmallHeight,
                    Container(
                      padding: defaultPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kSmallHeight,
                          TextBox(
                            text: 'Topic',
                          ),
                          kSmallHeight,
                          Text(
                            widget.topic.name,
                            style: smallPrimaryColor.copyWith(
                                fontSize: 19,
                                color: accentColor,
                                fontWeight: FontWeight.w600),
                          ),
                          kLargeHeight,
                          Text(widget.topic.description,
                              style:
                                  headingSmallGreyColor.copyWith(fontSize: 14)),
                          kLargeHeight,
                          quizResult.isEmpty ||
                                  AuthProvider.auth(context).user.role !=
                                      'child'
                              ? Container()
                              : GreenButton(
                                  submit: () {
                                    nextPage(context, widget.topic.id);
                                  },
                                  color: primaryColor,
                                  name: 'Take Quiz',
                                  buttonColor: secondaryColor,
                                  loader: false,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
