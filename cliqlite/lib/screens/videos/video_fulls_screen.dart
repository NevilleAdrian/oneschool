import 'package:better_player/better_player.dart';
import 'package:cliqlite/models/topic/topic.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/material.dart';

class VideoFullScreen extends StatefulWidget {
  static String id = 'fullscreen';

  VideoFullScreen({this.video, this.topic});
  final Video video;
  final Topic topic;

  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // print('widget.video.secureUrl: ${widget.topic.video.url}');
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, widget.topic.video.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(aspectRatio: 12 / 10),
        betterPlayerDataSource: betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            // widget.video.secureUrl == null
            //     ? Container(
            //         padding: EdgeInsets.only(
            //             top: 70, bottom: 20, left: 20, right: 20),
            //         decoration: BoxDecoration(
            //             color: Colors.black.withOpacity(0.4),
            //             image: DecorationImage(
            //               image: AssetImage("assets/images/video.png"),
            //               fit: BoxFit.cover,
            //             ),
            //             borderRadius: BorderRadius.only(
            //               bottomRight: Radius.circular(40),
            //               bottomLeft: Radius.circular(40),
            //             )),
            //         height: 230,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 InkWell(
            //                   onTap: () => Navigator.pop(context),
            //                   child: Icon(
            //                     Icons.keyboard_arrow_left,
            //                     color: blackColor,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   Icons.play_circle_fill,
            //                   color: whiteColor,
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Icon(
            //                   Icons.fullscreen,
            //                   color: whiteColor,
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       )
            //     :
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kSmallHeight,
                  // InkWell(
                  //   onTap: () => Navigator.pop(context),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.keyboard_arrow_left,
                  //         color: blackColor,
                  //       ),
                  //       Text('Back')
                  //     ],
                  //   ),
                  // ),
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
                    child: BetterPlayer(
                      controller: _betterPlayerController,
                    ),
                  ),
                  kSmallHeight,
                  Container(
                    padding: defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Icon(
                        //           Icons.favorite_border,
                        //           color: primaryColor,
                        //         ),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         Text(
                        //           'Save',
                        //           style:
                        //               smallPrimaryColor.copyWith(fontSize: 14),
                        //         )
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(
                        //           Icons.share_outlined,
                        //           color: primaryColor,
                        //         ),
                        //         SizedBox(
                        //           width: 5,
                        //         ),
                        //         Text(
                        //           'Share',
                        //           style:
                        //               smallPrimaryColor.copyWith(fontSize: 14),
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // ),
                        // kSmallHeight,
                        // Divider(
                        //   thickness: 0.9,
                        // ),
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
                        GreenButton(
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
    );
  }
}
