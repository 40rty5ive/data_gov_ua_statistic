import 'package:data_gov_ua_statistic/models/trade_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordsTalble extends StatelessWidget {
  const RecordsTalble({super.key, required this.data});

  final TradeData data;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Period',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Volume',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        for (final record in data.records)
          TableRow(
            decoration: BoxDecoration(
              color: record.attributes == Attribute.exports ? const Color.fromARGB(255, 231, 247, 254) : Colors.white,
            ),
            children: [
              Text(record.attributes.name),
              Text(DateFormat('y MMMM').format(record.period)),
              Text(record.data.toString()),
            ],
          ),
      ],
    );
  }
}
