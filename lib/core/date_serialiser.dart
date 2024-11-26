import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

class DateTimeSerialiser implements JsonConverter<DateTime, dynamic> {
  const DateTimeSerialiser();

  @override
  DateTime fromJson(dynamic json) {
    if ((json as String).length > 7) {
      return DateFormat('yyyy dd-MM').parse(json.toString());
    }
    if ((json).contains('-')) {
      return DateFormat('yyyy-MM').parse(json.toString());
    } else {
      return DateFormat('yyyy MM').parse(json.toString());
    }
  }

  @override
  dynamic toJson(DateTime date) => date.toIso8601String();
}
