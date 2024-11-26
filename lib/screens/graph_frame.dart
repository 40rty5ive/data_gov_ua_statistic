import 'package:data_gov_ua_statistic/models/trade_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphFrame extends StatelessWidget {
  const GraphFrame({super.key, required this.data});

  final TradeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: AspectRatio(
        aspectRatio: 1.25,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Export and import dynamics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 25, left: 2.5, bottom: 10, top: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -100,
                  child: _LineChart(
                    chartData: data,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.chartData});

  final TradeData chartData;

  @override
  Widget build(BuildContext context) {
    return LineChart(lineChartData);
  }

  LineChartData get lineChartData => LineChartData(
         lineTouchData: lineTouchData(),
        // gridData: gridData(),
        // titlesData: titlesData(),
        // borderData: borderData(),
        lineBarsData: lineBarsData(),
        // minX: 0,
        // maxX: 6000000,
        // minY: 0,
        // maxY: 6000000,
      );

  LineTouchData lineTouchData() => const LineTouchData(
        handleBuiltInTouches: true,
      );

  FlGridData gridData() => FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (double _) => FlLine(
          color: Colors.white.withOpacity(0.2),
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (double _) => FlLine(
          color: Colors.white.withOpacity(0.2),
          strokeWidth: 1,
        ),
      );

  FlTitlesData titlesData() => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles(),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  SideTitles bottomTitles() => SideTitles(
        getTitlesWidget: bottomTitleWidgets,
        interval: 1,
        reservedSize: 32,
        showTitles: true,
      );

  SideTitleWidget bottomTitleWidgets(double value, TitleMeta meta) {
    String text = DateFormat('y MMMM').format(DateTime.fromMicrosecondsSinceEpoch(value.toInt()));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
        //    getTitlesWidget: leftTitleWidgets,
        interval: 1,
        reservedSize: 40,
        showTitles: true,
      );

  // Text leftTitleWidgets(double value, TitleMeta meta) {
  //   String text = switch (value.toInt()) {
  //     1 => '5',
  //     2 => '10',
  //     3 => '15',
  //     4 => '20',
  //     5 => '25',
  //     6 => '30',
  //     7 => '35',
  //     _ => '',
  //   };

  //   return Text(
  //     text,
  //     textAlign: TextAlign.center,
  //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
  //   );
  // }

  FlBorderData borderData() => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF50E4FF).withOpacity(0.2),
            width: 4,
          ),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> lineBarsData() => [
        lineChartBarDataCurrentWeek(),
        lineChartBarDataPreviousWeek(),
      ];

  LineChartBarData lineChartBarDataCurrentWeek() => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0xFF50E4FF),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...chartData.records
              .sublist(20)
              .where((record) => record.attributes == Attribute.exports)
              .toList()
              .map<FlSpot>(
                (e) => FlSpot(e.period.microsecondsSinceEpoch.toDouble(), double.parse(e.data)),
              ),
        ],
      );

  LineChartBarData lineChartBarDataPreviousWeek() => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.deepOrangeAccent.withOpacity(0.8),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...chartData.records
              .sublist(20)
              .where((record) => record.attributes == Attribute.imports)
              .toList()
              .map<FlSpot>(
                (e) => FlSpot(e.period.microsecondsSinceEpoch.toDouble(), double.parse(e.data)),
              ),
        ],
      );
}
