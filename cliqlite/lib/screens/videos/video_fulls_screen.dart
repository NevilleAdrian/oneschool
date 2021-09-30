import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VideoFullScreen extends StatefulWidget {
  @override
  _VideoFullScreenState createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
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
                        'Performance',
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                      Icon(
                        Icons.bookmark_border,
                        color: blackColor,
                      )
                    ],
                  ),
                  kSmallHeight,
                  Text(
                    '1 hour 20 min',
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
