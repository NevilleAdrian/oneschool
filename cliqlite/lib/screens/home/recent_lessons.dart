import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';

class RecentLessons extends StatefulWidget {
  @override
  _RecentLessonsState createState() => _RecentLessonsState();
}

class _RecentLessonsState extends State<RecentLessons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackArrow(text: 'Recently viewed lessons'),
            kLargeHeight,
            SwipeItems(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwipeChild(
                    height: 140,
                  )
                ],
              ),
            ),
            kSmallHeight,
            SwipeItems(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwipeChild(
                    height: 140,
                  )
                ],
              ),
            ),
            kSmallHeight,
            SwipeItems(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwipeChild(
                    height: 140,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
