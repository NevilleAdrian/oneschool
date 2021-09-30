/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  // final List<charts.Series> seriesList;
  // final bool animate;
  //
  // SimpleBarChart(this.seriesList, {this.animate});

  // /// Creates a [BarChart] with sample data and no transition.
  // factory SimpleBarChart.withSampleData() {
  //   return new SimpleBarChart(
  //     _createSampleData(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: whiteColor,
          ),
      child: new charts.BarChart(
        _createSampleData(),
        defaultRenderer: charts.BarRendererConfig(
          maxBarWidthPx: 5,
        ),
        animate: true,
        // domainAxis: charts.TextStyleSpec(color: Colors.red),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('Maths', 75),
      new OrdinalSales('Eng', 100),
      new OrdinalSales('Comp', 60),
      new OrdinalSales('Arts', 50),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.Color.fromHex(code: '#016F56'),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
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
