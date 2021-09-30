import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/bar_chart.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indexed/indexed.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

enum Type { subject, topic, grades }

class _AnalyticsState extends State<Analytics> {
  Type type = Type.subject;

  bool show = false;

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Performance',
                      textAlign: TextAlign.center,
                      style: textStyleSmall.copyWith(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
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
                Row(
                  children: [
                    SubMenu(
                      text: 'By Subject',
                      onTap: () {
                        setState(() => type = Type.subject);
                      },
                      style: type == Type.subject
                          ? heading18Black.copyWith(fontSize: 16)
                          : headingGrey.copyWith(
                              color: greyColor, fontSize: 16),
                      widget: type == Type.subject
                          ? SvgPicture.asset('assets/images/svg/circle.svg')
                          : Container(
                              height: 7,
                            ),
                    ),
                    kSmallWidth,
                    SubMenu(
                      text: 'By Topic',
                      onTap: () {
                        setState(() => type = Type.topic);
                      },
                      style: type == Type.topic
                          ? heading18Black.copyWith(fontSize: 16)
                          : headingGrey.copyWith(
                              color: greyColor, fontSize: 16),
                      widget: type == Type.topic
                          ? SvgPicture.asset('assets/images/svg/circle.svg')
                          : Container(
                              height: 7,
                            ),
                    ),
                    kSmallWidth,
                    SubMenu(
                      text: 'By Grades',
                      onTap: () {
                        setState(() => type = Type.grades);
                      },
                      style: type == Type.grades
                          ? heading18Black.copyWith(fontSize: 16)
                          : headingGrey.copyWith(
                              color: greyColor, fontSize: 16),
                      widget: type == Type.grades
                          ? SvgPicture.asset('assets/images/svg/circle.svg')
                          : Container(
                              height: 7,
                            ),
                    ),
                  ],
                ),
                kLargeHeight,
                PerformanceBox(
                  percentage: 70,
                  text: type == Type.subject
                      ? 'Highest'
                      : (type == Type.topic ? 'Best Performing' : 'Overall'),
                  subText: type == Type.subject
                      ? 'Performance'
                      : (type == Type.topic ? 'Topic' : 'Grade'),
                  subject: type == Type.subject
                      ? 'English'
                      : (type == Type.topic ? 'English' : 'English'),
                ),
                kLargeHeight,
                Indexer(
                  children: [
                    Indexed(
                      index: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Your Result',
                              style: textLightBlack.copyWith(fontSize: 18),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.bottomCenter,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Filter',
                                        style: textGrey.copyWith(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: greyColor,
                                      )
                                    ],
                                  ),
                                ),
                                show
                                    ? Positioned(
                                        bottom: -140,
                                        // left: 0,
                                        // right: 0,
                                        child: Container(
                                          padding: defaultVHPadding,
                                          decoration:
                                              BoxDecoration(color: whiteColor),
                                          child: Column(
                                            children: [
                                              Text('Highest to Lowest'),
                                              kSmallHeight,
                                              Text('Lowest to Highest'),
                                            ],
                                          ),
                                        ))
                                    : Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    kLargeHeight,
                    Indexed(
                      index: 2,
                      child: Container(
                          height: 300,
                          padding: defaultVHPadding.copyWith(left: 0, right: 0),
                          child: SimpleBarChart()),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PerformanceBox extends StatelessWidget {
  const PerformanceBox(
      {this.text, this.subText, this.subject, this.percentage});

  final String text;
  final String subText;
  final String subject;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultVHPadding.copyWith(left: 25, right: 25),
      decoration: BoxDecoration(
          color: veryLightPrimaryColor,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 5.0,
            percent: percentage / 100,
            center: new Text(
              "${percentage.toString()}%",
              style: textLightBlack.copyWith(fontSize: 21),
            ),
            progressColor: primaryColor,
          ),
          kSmallWidth,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: textLightBlack.copyWith(fontSize: 18),
              ),
              kVerySmallHeight,
              Text(subText, style: textLightBlack.copyWith(fontSize: 18)),
              kVerySmallHeight,
              Text(
                'in $subject',
                style: textExtraLightBlack.copyWith(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}