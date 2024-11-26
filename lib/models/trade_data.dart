import 'package:data_gov_ua_statistic/core/date_serialiser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_data.freezed.dart';
part 'trade_data.g.dart';

@freezed
class TradeData with _$TradeData {
  const factory TradeData({
    required List<TradeRecord> records,
  }) = _TradeData;

  factory TradeData.fromJson(Map<String, dynamic> json) => _$TradeDataFromJson(json);
}

@freezed
class TradeRecord with _$TradeRecord {
  const factory TradeRecord({
    @JsonKey(name: 'code') required Attribute attributes,
    @DateTimeSerialiser() required DateTime period,
    required String data,
  }) = _TradeRecord;

  factory TradeRecord.fromJson(Map<String, dynamic> json) => _$TradeRecordFromJson(json);
}

enum Attribute {
  @JsonValue('01')
  exports,
  @JsonValue('02')
  imports,
}
