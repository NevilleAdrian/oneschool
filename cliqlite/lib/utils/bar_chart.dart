/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cliqlite/models/analytics/analytics_topic/analytics_topic.dart';
import 'package:flutter/material.dart';

// class SimpleBarChart extends StatelessWidget {
//   SimpleBarChart({this.topic, this.subject, this.type});
//   final List<AnalyticTopic> topic;
//   final List<AnalyticSubject> subject;
//   final Type type;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           // color: whiteColor,
//           ),
//       child: new charts.BarChart(
//         type == Type.subject
//             ? _createSubjectData(subject)
//             : _createTopicData(topic),
//         defaultRenderer: charts.BarRendererConfig(
//           maxBarWidthPx: 5,
//         ),
//         animate: true,
//         // domainAxis: charts.TextStyleSpec(color: Colors.red),
//       ),
//     );
//   }
//
//   /// Create one series with sample hard coded data.
//   static List<charts.Series<AnalyticSubject, String>> _createSubjectData(
//       List<AnalyticSubject> subject) {
//     // final data = [
//     //   OrdinalSales('Maths', 75),
//     //   OrdinalSales('Eng', 100),
//     //   OrdinalSales('Comp', 60),
//     //   OrdinalSales('Arts', 50),
//     // ];
//     final data = subject;
//
//     return [
//       new charts.Series<AnalyticSubject, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#016F56'),
//         domainFn: (AnalyticSubject subject, _) => subject.subjectInfo[0].name,
//         measureFn: (AnalyticSubject subject, _) =>
//             subject.subjectPercentile.toInt(),
//         data: data,
//       )
//     ];
//   }
//
//   static List<charts.Series<AnalyticTopic, String>> _createTopicData(
//       List<AnalyticTopic> topic) {
//     // final data = [
//     //   OrdinalSales('Maths', 75),
//     //   OrdinalSales('Eng', 100),
//     //   OrdinalSales('Comp', 60),
//     //   OrdinalSales('Arts', 50),
//     // ];
//     final data = topic;
//
//     return [
//       new charts.Series<AnalyticTopic, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.Color.fromHex(code: '#016F56'),
//         domainFn: (AnalyticTopic subject, _) => subject.topicInfo[0].title,
//         measureFn: (AnalyticTopic subject, _) =>
//             subject.topicPercentile.toInt(),
//         data: data,
//       )
//     ];
//   }
// }
//
// /// Sample ordinal data type.
// class OrdinalSales {
//   final String year;
//   final int sales;
//
//   OrdinalSales(this.year, this.sales);
// }

class PointsLineChart extends StatelessWidget {
  final List<Graph> graph;
  final bool animate;

  PointsLineChart(this.graph, {this.animate});

  // /// Creates a [LineChart] with sample data and no transition.
  // factory PointsLineChart.withSampleData() {
  //   return new PointsLineChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: true,
  //   );
  // }

  final yAxis = charts.BasicNumericTickFormatterSpec((num value) {
    print('val:$value');
    if (value == 0) {
      return "0%";
    } else if (value >= 0) {
      return "20%";
    } else if (value >= 20) {
      return "40%";
    } else if (value >= 40) {
      return "60%";
    } else if (value >= 60) {
      return "80%";
    } else if (value >= 80) {
      return "100%";
    } else {
      return null;
    }
  });

  final xAxis = charts.BasicNumericTickFormatterSpec((num value) {
    print('value:$value');
    if (value == 1) {
      return "January";
    } else if (value == 2) {
      return "February";
    } else if (value == 3) {
      return "March";
    } else if (value == 4) {
      return "April";
    } else if (value == 5) {
      return "May";
    } else if (value == 6) {
      return "June";
    } else if (value == 7) {
      return "July";
    } else if (value == 8) {
      return "August";
    } else if (value == 9) {
      return "September";
    } else if (value == 10) {
      return "October";
    } else if (value == 11) {
      return "November";
    } else if (value == 12) {
      return "December";
    } else {
      return '';
    }
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: charts.LineChart(_createSampleData(graph),
          animate: true,
          domainAxis: charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shade400,
                thickness: 1,
              )),
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
              tickFormatterSpec: xAxis,
              showAxisLine: true),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                  lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shade400,
                thickness: 1,
              )),
              tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                desiredTickCount: 5,
              ),
              // tickFormatterSpec: yAxis,
              showAxisLine: true),
          defaultRenderer:
              charts.LineRendererConfig(includePoints: true, stacked: true)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Graph, int>> _createSampleData(List<Graph> graph) {
    // final data = [
    //   new LinearSales(0, 5),
    //   new LinearSales(1, 25),
    //   new LinearSales(2, 100),
    //   new LinearSales(3, 75),
    //   new LinearSales(4, 50),
    //   new LinearSales(5, 10),
    //   new LinearSales(6, 40),
    // ];

    final data = graph;
    print('data:$graph');

    return [
      new charts.Series<Graph, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Graph sales, _) {
          print('year:${sales.score}');
          return sales.id.month;
        },
        measureFn: (Graph sales, _) => sales.score,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
