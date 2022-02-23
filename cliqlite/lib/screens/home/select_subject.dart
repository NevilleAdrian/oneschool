import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/videos/videos.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class SelectSubject extends StatefulWidget {
  static String id = 'select';
  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  Future<List<Video>> futureVideos;

  Future<List<Video>> futureTask() async {
    //Initialize provider
    VideoProvider video = VideoProvider.video(context);

    //Make call to get videos
    var result = await video.getVideos();

    setState(() {});

    //Return future value
    return Future.value(result);
  }

  Widget videos(List<Video> video) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackArrow(),
            kLargeHeight,
            Container(
              padding: defaultPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select any subject to start',
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  kSmallHeight,
                  SearchCard(),
                  kSmallHeight,
                  Column(
                    children: [
                      // TextBox(
                      //   text: 'All video lessons available',
                      // ),
                      kSmallHeight,
                      Container(
                        height: 370,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 100,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 20),
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, QuizScreen.id),
                                child: SwipeItems(
                                  image: 'assets/images/Frame-1.png',
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('assets/images/dna.png'),
                                      Text(
                                        'Biology',
                                        style: heading18,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
    VideoProvider video = VideoProvider.video(context);

    return BackgroundImage(
      child: FutureHelper(
        task: futureVideos,
        loader: video?.videos == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [circularProgressIndicator()],
              )
            : videos(video.videos),
        builder: (context, _) => videos(video.videos),
      ),
    );
  }
}
