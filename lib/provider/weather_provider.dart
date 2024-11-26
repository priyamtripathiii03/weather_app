import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api_helper/api_helper.dart';
import 'package:weather_app/model/weather_model.dart';

class HomeProvider extends ChangeNotifier {
  List<String> weather = [];
  WeatherModal? weatherModal;
  String search = "Surat";
  int selectedIndex = 0;

  void Searchweather(String search) {
    this.search = search;
    notifyListeners();
  }

  void SelectedImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<WeatherModal?> fromMap(String search) async {
    Map<String, dynamic> data =
        await ApiHelper.apihelper.fetchApiData(search: search);
    weatherModal = WeatherModal.fromJson(data);
    return weatherModal;
  }

  Future<void> addFavCity(String name, String temp, String type) async {
    String data = '$name-$temp-$type';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather.add(data);
    // weather.clear();
    sharedPreferences.setStringList('weather', weather);
  }

  Future<void> getFavouriteWeather() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    weather = sharedPreferences.getStringList('weather') ?? <String>[];
    notifyListeners();
  }

  void Delete(int index) {
    weather.removeAt(index);
    notifyListeners();
  }

  HomeProvider() {
    getFavouriteWeather();
  }
}
