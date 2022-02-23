import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:cliqlite/screens/account/feedback/feedback.dart';
import 'package:cliqlite/screens/background/background.dart';
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

class TopicVideos extends StatefulWidget {
  TopicVideos({this.topicID, this.name, this.subscribed, this.subjectId});

  final String topicID;
  final String name;
  final bool subscribed;
  final String subjectId;
  @override
  _TopicVideosState createState() => _TopicVideosState();
}

class _TopicVideosState extends State<TopicVideos> {
  Future<List<Video>> futureVideos;

  List<Video> videos;

  Future<List<Video>> futureTask() async {
    //Initialize provider
    VideoProvider video = VideoProvider.video(context);

    //Make call to get videos
    var result = await video.getTopicVideos(widget.topicID);

    setState(() {
      videos = result;
    });

    //Return future value
    return Future.value(result);
  }

  nextPage() {
    if (widget.subscribed) {
      Navigator.pushNamed(context, QuizScreen.id);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => QuizScreen(
      //               topicId: widget.topicID,
      //               subjectId: widget.subjectId,
      //               name: widget.name,
      //             )));
    } else {
      Navigator.pushNamed(context, MakeSubscription.id);
    }
  }

  feedback() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FeedBackScreen(
                  topicID: widget.topicID,
                  name: widget.name,
                )));
  }

  Widget videoScreen(List<Video> video) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: defaultVHPadding.copyWith(left: 15, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackArrow(
                    text: '',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            kSmallHeight,
            Padding(
              padding: defaultVHPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: heading18Black,
                  ),
                  kSmallHeight,
                  Text(
                    'Lorem ipsum dolor sit amet, consecte tur adipiscing elit. Vulputate faucibus tempus ac viverra netus auctor eu, natoque. ',
                    style: headingSmallBlack,
                  ),
                  kSmallHeight,
                  Row(
                    children: [
                      Expanded(
                        child: LargeButton(
                          submit: () => nextPage(),
                          height: 50,
                          color: primaryColor,
                          name: 'Take Quiz',
                          buttonColor: secondaryColor,
                        ),
                      ),
                      kSmallWidth,
                      Expanded(
                        child: LineButton(
                          fontSize: 17,
                          onPressed: () => feedback(),
                          text: 'Feedback',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: defaultVHPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Videos',
                    style: heading18Black,
                  ),
                  kSmallHeight,
                  videos.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Videos',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : GroupedVerticalWidgets(
                          video: video,
                          subscribed: widget.subscribed,
                          context: context,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureVideos = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: FutureHelper(
        task: futureVideos,
        loader: videos == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [circularProgressIndicator()],
              )
            : videoScreen(videos),
        builder: (context, _) => videoScreen(videos),
      ),
    );
  }
}

class GroupedVerticalWidgets extends StatelessWidget {
  const GroupedVerticalWidgets({
    this.video,
    this.subscribed,
    this.context,
  });

  final List<Video> video;
  final bool subscribed;
  final BuildContext context;

  onTapVideo(Video video) {
    if (subscribed) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoFullScreen(
                    video: video,
                  )));
    } else {
      Navigator.pushNamed(context, MakeSubscription.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            itemCount: video.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 40,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => onTapVideo(video[index]),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/item-image.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 124,
                          ),
                        ),
                        // FadeInImage(
                        //   image: NetworkImage(data[0]['image']),
                        //   placeholder: AssetImage(
                        //     data[0]['image'],
                        //   ),
                        //   width: 99,
                        //   fit: BoxFit.cover,
                        // ),
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                              )
                            ],
                          ),
                          bottom: 0,
                          top: 0,
                          right: 0,
                          left: 0,
                        )
                      ],
                    ),
                    kSmallHeight,
                    Text(
                      video[index].title,
                      style: headingWhite.copyWith(
                          fontSize: 13, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            })
      ],
    );
  }
}
