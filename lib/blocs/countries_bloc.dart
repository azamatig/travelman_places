import 'package:flutter/material.dart';
import 'package:travelman/models/countries.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CountriesList extends ChangeNotifier {
  List<AviaSalesCountriesModel> _data = [];
  List<AviaSalesCountriesModel> get data => _data;

  Future getCountries(String stateName, String timestamp) async {
    _data.clear();
    var url = 'http://api.travelpayouts.com/data/en-GB/countries.json';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['code'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  onRefresh(mounted, String stateName, String timestamp) {
    _data.clear();
    getCountries(stateName, timestamp);
    notifyListeners();
  }
}
