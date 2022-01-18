import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static var _baseUrl =
      "https://262535b6-544d-4d64-b381-6df9c7db6e31.mock.pstmn.io/get-weather-information?city=";

  static Future<dynamic> getCityInfo({required cityName}) async {
    try {
      var uri = Uri.parse(_baseUrl + cityName);
      print("api request : "+uri.toString());
      var response = await http.get(uri);
      print("response : ${response.body}");
      return [true, jsonDecode(response.body)];
    } catch (err) {
      print("err : ${err}");
      return [false];
    }
  }
}
