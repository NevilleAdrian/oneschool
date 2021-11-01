import 'package:better_player/better_player.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoFullScreen extends StatefulWidget {
  VideoFullScreen({this.video});
  final Video video;
  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    print('widget.video.secureUrl: ${widget.video.secureUrl}');
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, '${widget.video.secureUrl}');
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
    return BackgroundImage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.video.secureUrl == null
                ? Container(
                    padding: EdgeInsets.only(
                        top: 70, bottom: 20, left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        image: DecorationImage(
                          image: AssetImage("assets/images/video.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        )),
                    height: 230,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              color: whiteColor,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.fullscreen,
                              color: whiteColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kSmallHeight,
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_left,
                                color: blackColor,
                              ),
                              Text('Back')
                            ],
                          ),
                        ),
                        kSmallHeight,
                        BetterPlayer(
                          controller: _betterPlayerController,
                        )
                      ],
                    ),
                  ),
            kSmallHeight,
            Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.video.title ?? '',
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                      // Icon(
                      //   Icons.bookmark_border,
                      //   color: blackColor,
                      // )
                    ],
                  ),
                  kSmallHeight,
                  Text(
                    widget.video.duration.toString(),
                    style: textExtraLightBlack,
                  ),
                  kLargeHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About this video',
                        style: textLightBlack,
                      ),
                      kSmallHeight,
                      Text(
                        'Lorem ipsum dolor sit amet, consecte tur adipiscing elit. Vulputate faucibus tempus ac viverra netus auctor eu, natoque. ',
                        style: textExtraLightBlack,
                      ),
                    ],
                  ),
                  kLargeHeight,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reviews',
                        style: textLightBlack,
                      ),
                      kSmallHeight,
                      Text(
                        '• Lorem ipsum dolor sit amet, consecte tur adipiscing elit. Vulputate faucibus tempus ac viverra netus auctor eu, natoque. ',
                        style: textExtraLightBlack,
                      ),
                      kLargeHeight,
                      Text(
                        '• Lorem ipsum dolor sit amet, consecte tur adipiscing elit. Vulputate faucibus tempus ac viverra netus auctor eu, natoque. ',
                        style: textExtraLightBlack,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
