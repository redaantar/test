// this remote data source is responsible for fetching data from the server
// but this is just a dummy data source to show how you can use a remote data source
// we are using a local json file to fetch data

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/models/overview_model.dart';

class OverViewRemoteDatasource {
  
  Future<OverViewModel> getOverViewData() async {
    String jsonString = await rootBundle.loadString('assets/mocks/overview_data.json');
    await Future.delayed(const Duration(seconds: 2)); // to simulate network delay
    final data = json.decode(jsonString);
    return OverViewModel.fromJson(data);
  }

}