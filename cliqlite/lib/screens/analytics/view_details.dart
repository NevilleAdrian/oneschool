import 'package:cliqlite/models/analytics/test_results/test_results.dart';
import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewDetails extends StatefulWidget {
  static String id = 'view-details';
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  Future<List<TestResults>> futureTestResults;
  var testResults;

  Future<List<TestResults>> futureTask() async {
    //Initialize provider
    AnalyticsProvider analytic = AnalyticsProvider.analytics(context);

    //Make call to get videos
    try {
      setState(() {});
      testResults = await analytic.getTestResults();
      print('test:${testResults}');

      //Return future value
      return Future.value(testResults);
    } catch (ex) {}
  }

  Widget test() {
    return Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                separatorBuilder: (context, _) => SizedBox(
                  height: 10,
                ),
                itemCount: testResults.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ViewItems(
                  name: testResults[index].quiz.title,
                  subject: testResults[index].subject.name,
                  topic: testResults[index].topic.name,
                  score: testResults[index].score,
                  total: testResults[index].totalQuestions,
                  percentage: testResults[index].percentage.ceil(),
                ),

                // physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    futureTestResults = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TestResults> testResults =
        AnalyticsProvider.analytics(context)?.testResults;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackArrow(
              text: 'Test Results',
            ),
            kSmallHeight,
            FutureHelper(
                task: futureTestResults,
                loader: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [circularProgressIndicator()],
                ),
                builder: (context, _) => test())
          ],
        ),
      ),
    );
  }
}

class ViewItems extends StatelessWidget {
  const ViewItems({
    Key key,
    this.name,
    this.subject,
    this.topic,
    this.score,
    this.total,
    this.percentage,
  }) : super(key: key);

  final String name;
  final String subject;
  final String topic;
  final int score;
  final int total;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(toBeginningOfSentenceCase(name.toLowerCase()),
                    style: smallPrimaryColor.copyWith(
                        color: accentColor, fontSize: 16)),
                kVerySmallHeight,
                Text('$percentage%  |  $score/$total',
                    style: headingSmallGreyColor.copyWith(fontSize: 14)),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(subject,
                      style: headingSmallGreyColor.copyWith(fontSize: 14)),
                  kVerySmallHeight,
                  Text(
                    toBeginningOfSentenceCase(topic.toLowerCase()),
                    style: headingSmallGreyColor.copyWith(fontSize: 14),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
        kSmallHeight,
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
