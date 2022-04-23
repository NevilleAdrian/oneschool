import 'package:cliqlite/models/analytics/analytics_subject/analytics_subject.dart';
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/analytics/view_details.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/bar_chart.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

enum Type { subject, topic, grades }

class _AnalyticsState extends State<Analytics> {
  Type type = Type.subject;

  bool show = false;

  Future<AnalyticTopic> futureTopic;

  String profilePic;

  String val = 'All time';

  Future<AnalyticTopic> futureTask() async {
    //Initialize provider
    AnalyticsProvider analytic = AnalyticsProvider.analytics(context);

    var topicResult;
    //Make call to get videos
    try {
      setState(() {});
      topicResult = await analytic.getTopic();

      //Return future value
      return Future.value(topicResult);
    } catch (ex) {}
  }

  @override
  void initState() {
    futureTopic = futureTask();
    super.initState();
  }

  Widget analyticsScreen() {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    List<AnalyticSubject> subjectList =
        AnalyticsProvider.analytics(context)?.subject;
    AnalyticTopic topicList = AnalyticsProvider.analytics(context)?.topic;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Performance Analytics',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                ],
              ),
              kLargeHeight,
              TextBox(
                text: 'Overview',
              ),
              kSmallHeight,
              Row(
                children: [
                  AnalyticsBox(
                    text: 'Highest Performing Subject',
                    image: 'perform',
                    footer: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${topicList.highestPerformingSubject?.no?.ceil().toString()}%',
                            style: headingSmallGreyColor.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        kVerySmallHeight,
                        Text('${topicList.highestPerformingSubject.name}',
                            style: headingSmallGreyColor.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                  kSmallWidth,
                  AnalyticsBox(
                    text: 'Video lessons viewed',
                    image: 'accelerate',
                    number: '${topicList.videosWatched ?? 0}',
                  )
                ],
              ),
              kSmallHeight,
              Row(
                children: [
                  // AnalyticsBox(
                  //   text: 'Live tutor Classes Attended',
                  //   image: 'person',
                  //   number: '10',
                  // ),
                  // kSmallWidth,
                  AnalyticsBox(
                    text: 'Number of Quiz completed',
                    image: 'docx',
                    number: '${topicList.quizCompleted}',
                  )
                ],
              ),
              kLargeHeight,
              topicList.graph.isEmpty
                  ? Container()
                  : TextBox(
                      text: 'Quiz results',
                    ),
              kSmallHeight,
              topicList.graph.isEmpty
                  ? Container()
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: greyColor, width: 0.6)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Analytics',
                                style: textGrey.copyWith(fontSize: 12),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: Color(0XFFEDEFF2),
                              //       borderRadius: BorderRadius.circular(30)),
                              //   height: 40,
                              //   // width: 80,
                              //   child: DropdownButtonHideUnderline(
                              //     child: ButtonTheme(
                              //       minWidth: 5,
                              //       // alignedDropdown: true,
                              //       child: DropdownButton<String>(
                              //         value: val,
                              //         items: <String>[
                              //           'All time',
                              //           'Last Year',
                              //           'This Year',
                              //         ].map((String value) {
                              //           return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: Text(
                              //               value,
                              //               style: textGrey.copyWith(fontSize: 12),
                              //             ),
                              //           );
                              //         }).toList(),
                              //         onChanged: (String value) {
                              //           setState(() => val = value);
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              //   padding:
                              //       EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                              // ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, ViewDetails.id),
                                child: Text(
                                  'View Details',
                                  style: smallPrimaryColor.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                          // kVerySmallHeight,
                          Container(
                            height: 250,
                            child: PointsLineChart(topicList.graph),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AnalyticsProvider analytic = AnalyticsProvider.analytics(context);

    return FutureHelper(
      task: futureTopic,
      loader: analytic.topic == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [circularProgressIndicator()],
            )
          : analyticsScreen(),
      noData: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('No data available')],
      ),
      builder: (context, _) => analyticsScreen(),
    );
  }
}

class AnalyticsBox extends StatelessWidget {
  const AnalyticsBox({
    Key key,
    this.text,
    this.image,
    this.footer,
    this.number,
  }) : super(key: key);

  final String text;
  final String image;
  final Widget footer;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 145,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: greyColor, width: 0.6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: headingSmallGreyColor,
                  ),
                ),
                kSmallWidth,
                SvgPicture.asset('assets/images/svg/$image.svg')
              ],
            ),
            kSmallHeight,
            footer ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(number.toString(),
                        style: headingSmallGreyColor.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 26)),
                  ],
                )
          ],
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
