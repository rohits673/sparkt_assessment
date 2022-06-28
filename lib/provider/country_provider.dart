import 'dart:convert';

import 'package:sparkt_assessment/model/country.dart';
import 'package:sparkt_assessment/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CountryProvider with ChangeNotifier {
  CountryProvider() {
    loadCountries().then((countries) {
      _countries = countries;
      notifyListeners();
    });
  }

  List<Country> _countries = [];

  void setCountries(List<Country> country) {
    _countries = country;
    notifyListeners();
  }

  List<Country> get countries => _countries;

  Future loadCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    if (response.statusCode == 200) {
      List countryJson = json.decode(response.body);
      return countryJson.map((data) => Country.fromJson(data)).toList()
        ..sort(CountryUtils.ascendingSort);
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
