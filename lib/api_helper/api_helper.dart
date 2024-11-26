import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper apihelper = ApiHelper._();
  ApiHelper._();

  Future<Map<String, dynamic>> fetchApiData({String search = "SURAT"}) async {
    String api = "https://api.weatherapi.com/v1/forecast.json?key=c0fe1ad1d1c54177b8b101154243007&q=$search";
    Uri url = Uri.parse(api);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      // Cast to Map<String, dynamic> to match expected type
      Map<String, dynamic> data = jsonDecode(json) ;
      return data;
    } else {
      return {};
    }
  }
}
