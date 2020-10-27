import 'package:flutter/material.dart';
import 'package:weather_app/weather/model/Sys.dart';
import 'package:weather_app/weather/model/Temperature.dart';

class ForecastList {
  final ForecastCity city;
  final List<Forecast> list;

  ForecastList({
    @required this.city,
    @required this.list,
  });

  factory ForecastList.parseMap(Map object) {
    return ForecastList(
      city: ForecastCity.parseMap(object['city']),
      list: Forecast.parseList(object['list']),
    );
  }
}

class Forecast {
  final Temperature temperature;
  final String date;
  final String description;
  final double windSpeed;

  Forecast({
    @required this.temperature,
    @required this.date,
    @required this.description,
    @required this.windSpeed,
  });

  static List<Forecast> parseList(List objectList) {
    List<Forecast> list = [];
    for (var item in objectList) list.add(Forecast.parseMap(item));
    return list;
  }

  factory Forecast.parseMap(Map object) {
    return Forecast(
      temperature: Temperature.parseMap(object['main']),
      date: object['dt_txt'],
      description: object['weather'][0]['description'],
      windSpeed: object['wind']['speed'].toDouble(),
    );
  }

  String get getDate {
    String date = this.date.split(' ')[0];
    String time = this.date.split(' ')[1];
    if (time == '00:00:00') return date.substring(5);
    return time.substring(0, 5);
  }

  bool get isNewDay {
    String time = this.date.split(' ')[1];
    return time == '00:00:00';
  }

  String get getTemperature {
    return '${this.temperature.temp.round()}˚';
  }
}
