import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String url;
  VideoApp({this.url});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // 'http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8'
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.chevron_left,
                        color: blackColor,
                      )),
                  Text(
                    "Subscription",
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  Container()
                ],
              ),
              kLargeHeight,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
