import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:data_gov_ua_statistic/constants.dart';
import 'package:data_gov_ua_statistic/models/trade_data.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_cybit_cubit.freezed.dart';
part 'main_cybit_state.dart';

class MainCybitCubit extends Cubit<MainCybitState> {
  MainCybitCubit() : super(MainCybitState(data: TradeData(records: [])));

  Future<void> init() async {
    final String response = await rootBundle.loadString(dataPath);
    final data = await json.decode(response) as List<dynamic>;
    final dataInEnglish = data.last as List<dynamic>;
    dataInEnglish.removeAt(0);

    final Map<String, dynamic> jsoForModel = {
      "records": dataInEnglish,
    };

    final model = TradeData.fromJson(jsoForModel);
    emit(MainCybitState(data: model));
  }
}
