import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api_helper/api_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  String search = 'Surat';
  ApiHelper apiHelper = ApiHelper();
  WeatherModal ? weatherModal;
  List <String> weather = [];

  Future<WeatherModal?> fromMap(String search) async {
    final data = await apiHelper.fetchApi(search);
    weatherModal = WeatherModal.fromJson(data);
    return weatherModal;
  }

  void searchCity(String city) {
    search = city;
    notifyListeners();
  }

  Future <void> addFavCity(String name, String temp, String type) async {
    String data = '$name-$temp-$type';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather.add(data);
    sharedPreferences.setStringList('weather',weather);
  }
  Future <void> getFavouriteWeather() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather = sharedPreferences.getStringList('weather') ?? <String>[];
    notifyListeners();
  }
  weatherProvider() {
    getFavouriteWeather();
  }
}