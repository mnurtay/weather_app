import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/weather/model/ForecastList.dart';
import 'package:weather_app/weather/model/Weather.dart';
import 'package:weather_app/weather/resource/weather_api_provider.dart';

class WeatherRepository {
  WeatherApiProvider _provider = WeatherApiProvider();
  final String _weatherKey = 'cities_weather';
  final String _cityKey = 'weather-';

  Future<List> getWeathers() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String jsonString = storage.getString(_weatherKey);
    if (jsonString == null) return [];
    List objectList = json.decode(jsonString);
    return objectList;
  }

  Future<ForecastList> getForcastWeather(String city) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String jsonString = storage.getString('$_cityKey$city');
    Map object = json.decode(jsonString);
    return ForecastList.parseMap(object);
  }

  Future<Weather> fetchWeather(String cityName) async {
    final requests = await Future.wait([
      _provider.fetchWeather(cityName),
      _provider.fetchForecast(cityName),
    ]);
    Map weatherObject = requests[0];
    Map forecastObject = requests[1];
    if (weatherObject == null) return null;
    await saveCityWeather(cityName, weatherObject);
    await saveForecastWeather(cityName, forecastObject);
    return Weather.parseMap(weatherObject);
  }

  Future<void> updateAll() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List objectList = await getWeathers();
    List<Weather> listWeather = Weather.parseList(objectList);
    List<Map> weathersObject = [];
    for (var item in listWeather) {
      final requests = await Future.wait([
        _provider.fetchWeather(item.city),
        _provider.fetchForecast(item.city),
      ]);
      weathersObject.add(requests[0]);
      await storage.setString(
          '$_cityKey${item.city}', json.encode(requests[1]));
    }
    await storage.setString(_weatherKey, json.encode(weathersObject));
  }

  Future<void> saveCityWeather(String city, Map object) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List objectList = await getWeathers();
    objectList.add(object);
    await storage.setString(_weatherKey, json.encode(objectList));
  }

  Future<void> saveForecastWeather(String city, Map object) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('$_cityKey$city', json.encode(object));
  }

  Future<void> removeAll() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
