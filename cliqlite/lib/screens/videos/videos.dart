import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    onPressed() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VideoFullScreen()));
    }

    return BackgroundImage(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, SearchScreen.id),
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
                kLargeHeight,
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    text: "Popular Videos",
                    onPressed: () => onPressed(),
                  ),
                ),
                kSmallHeight,
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    text: "Science Videos",
                    onPressed: () => onPressed(),
                  ),
                ),
                kSmallHeight,
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    text: "Art Videos",
                    onPressed: () => onPressed(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
