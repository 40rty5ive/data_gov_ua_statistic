import 'package:data_gov_ua_statistic/models/trade_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphFrame extends StatelessWidget {
  const GraphFrame({super.key, required this.data});

  final TradeData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Export and import dynamics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 25, left: 2.5, bottom: 10, top: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: _LineChart(
              chartData: data,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 20,
              color: const Color(0xFF50E4FF),
            ),
            Text(
              ' - Export',
            ),
            SizedBox(width: 40),
            Container(
              width: 40,
              height: 20,
              color: Colors.deepOrangeAccent.withOpacity(0.8),
            ),
            Text(
              ' - Import',
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
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
        //gridData: gridData(),
        titlesData: titlesData(),
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
        // interval: 10,
        reservedSize: 120,

        showTitles: true,
      );

  SideTitleWidget bottomTitleWidgets(double value, TitleMeta meta) {
    String text = DateFormat('y MMMM').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(value.round().toString())));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 45,
      angle: 1.55,
      child: Row(
        children: [
          Text(
            text,
          ),
        ],
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        //  interval: 1,
        reservedSize: 69,
        showTitles: true,
      );

  Text leftTitleWidgets(double value, TitleMeta meta) {
    String text = '${value / 100} B';

    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }

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
        lineChartBarDataExport(),
        lineChartBarDataImport(),
      ];

  LineChartBarData lineChartBarDataExport() => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0xFF50E4FF),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...chartData.records.where((record) => record.attributes == Attribute.exports).toList().map<FlSpot>(
                (e) => FlSpot(e.period.microsecondsSinceEpoch.toDouble(), double.parse(e.data)),
              ),
        ],
      );

  LineChartBarData lineChartBarDataImport() => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.deepOrangeAccent.withOpacity(0.8),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          ...chartData.records.where((record) => record.attributes == Attribute.imports).toList().map<FlSpot>(
                (e) => FlSpot(e.period.microsecondsSinceEpoch.toDouble(), double.parse(e.data)),
              ),
        ],
      );
}
