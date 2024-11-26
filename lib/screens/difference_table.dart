import 'package:data_gov_ua_statistic/models/trade_data.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class DifferenceTable extends StatelessWidget {
  const DifferenceTable({super.key, required this.data});

  final TradeData data;

  @override
  Widget build(BuildContext context) {
    final groupedRecords = data.records.groupListsBy((e) => e.period);
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              'Period',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Exports (\$ million)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Imports (\$ million)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Balance (\$ million)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        for (final record in groupedRecords.entries)
          TableRow(
            decoration: BoxDecoration(
              color: (double.parse(record.value.first.data) - double.parse(record.value.last.data)) < 0
                  ?  const Color.fromARGB(158, 244, 67, 54)
                  : const Color.fromARGB(158, 76, 175, 79),
            ),
            children: [
              Text(DateFormat('y MMMM').format(record.key)),
              Text(double.parse(record.value.first.data).toStringAsFixed(1)),
              Text(double.parse(record.value.last.data).toStringAsFixed(1)),
              Text((double.parse(record.value.first.data) - double.parse(record.value.last.data)).toStringAsFixed(1)),
            ],
          ),
      ],
    );
  }
}
