import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/video_provider/video_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
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
            Padding(
              padding: defaultVHPadding.copyWith(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, SearchScreen.id),
                    child: SearchBox(
                      type: 'route',
                      width: MediaQuery.of(context).size.width / 1.4,
                      placeholder: 'Search for Videos',
                    ),
                  ),
                  InkWell(
                    onTap: () => onTap(context),
                    child: Image.asset(
                      'assets/images/picture.png',
                    ),
                  )
                ],
              ),
            ),
            kLargeHeight,
            Container(
              padding: defaultPadding.copyWith(right: 0),
              child: GroupedWidgets(
                data: data,
                video: video,
                type: 'videos',
                text: "Popular Videos",
                // onPressed: () => onPressed(video),
              ),
            ),
            Container(
              padding: defaultPadding.copyWith(right: 0),
              child: GroupedWidgets(
                data: data,
                video: video,
                type: 'videos',
                text: "Science Videos",
                // onPressed: () => onPressed(video),
              ),
            ),
            Container(
              padding: defaultPadding.copyWith(right: 0),
              child: GroupedWidgets(
                data: data,
                video: video,
                type: 'videos',
                text: "Art Videos",
                // onPressed: () => onPressed(video),
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
