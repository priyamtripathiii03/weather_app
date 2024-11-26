import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper {
  Future <Map> fetchApi(String search) async {
    Uri url = Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=138c2e5f1ff140c8ad2101054243007&q=$search');
    Response response = await http.get(url);
    if(response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);
      return data;
    } else {
      return {};
    }
  }
}