/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cliqlite/models/analytics/analytics_subject/analytics_subject.dart';
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:cliqlite/screens/analytics/analytics.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  SimpleBarChart({this.topic, this.subject, this.type});
  final List<AnalyticTopic> topic;
  final List<AnalyticSubject> subject;
  final Type type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: whiteColor,
          ),
      child: new charts.BarChart(
        type == Type.subject
            ? _createSubjectData(subject)
            : _createTopicData(topic),
        defaultRenderer: charts.BarRendererConfig(
          maxBarWidthPx: 5,
        ),
        animate: true,
        // domainAxis: charts.TextStyleSpec(color: Colors.red),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<AnalyticSubject, String>> _createSubjectData(
      List<AnalyticSubject> subject) {
    // final data = [
    //   OrdinalSales('Maths', 75),
    //   OrdinalSales('Eng', 100),
    //   OrdinalSales('Comp', 60),
    //   OrdinalSales('Arts', 50),
    // ];
    final data = subject;

    return [
      new charts.Series<AnalyticSubject, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#016F56'),
        domainFn: (AnalyticSubject subject, _) => subject.subjectInfo[0].name,
        measureFn: (AnalyticSubject subject, _) =>
            subject.subjectPercentile.toInt(),
        data: data,
      )
    ];
  }

  static List<charts.Series<AnalyticTopic, String>> _createTopicData(
      List<AnalyticTopic> topic) {
    // final data = [
    //   OrdinalSales('Maths', 75),
    //   OrdinalSales('Eng', 100),
    //   OrdinalSales('Comp', 60),
    //   OrdinalSales('Arts', 50),
    // ];
    final data = topic;

    return [
      new charts.Series<AnalyticTopic, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#016F56'),
        domainFn: (AnalyticTopic subject, _) => subject.topicInfo[0].title,
        measureFn: (AnalyticTopic subject, _) =>
            subject.topicPercentile.toInt(),
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
