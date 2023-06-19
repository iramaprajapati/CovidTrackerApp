import 'dart:convert';

import 'package:flutter_covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:flutter_covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return WorldStatesModel.fromJson(jsonData);
    } else {
      throw Exception("Error");
    }
  }
  Future<List<dynamic>> countriesListApi() async {
    var countriesListApiJsonData;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      countriesListApiJsonData = jsonDecode(response.body);
      return countriesListApiJsonData;
    } else {
      throw Exception("Error");
    }
  }
}
