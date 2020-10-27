import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/config.dart';

class WeatherApiProvider {
  Future<Map> fetchWeather(String cityName) async {
    Response response;
    try {
      response = await get(
        '$API_URL/weather?q=$cityName&appid=$API_ID&lang=ru&units=metric',
      );
    } catch (e) {
      throw ("Нет соединения с интернетом. Проверьте соединение и попробуйте снова");
    }
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200)
      throw ('повторите попытку позже возникла внутренняя проблема');
    return json.decode(utf8.decode(response.bodyBytes));
  }

  Future<Map> fetchForecast(String cityName) async {
    Response response;
    try {
      response = await get(
        '$API_URL/forecast?q=$cityName&appid=$API_ID&lang=ru&units=metric',
      );
    } catch (e) {
      throw ("Нет соединения с интернетом. Проверьте соединение и попробуйте снова");
    }
    if (response.statusCode == 404) return null;
    if (response.statusCode != 200)
      throw ('повторите попытку позже возникла внутренняя проблема');
    return json.decode(utf8.decode(response.bodyBytes));
  }
}
