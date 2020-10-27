import 'package:flutter/material.dart';
import 'package:weather_app/weather/model/Sys.dart';
import 'package:weather_app/weather/model/Temperature.dart';

class Weather {
  final String description;
  final String city;
  final int cityId;
  final Temperature temperature;
  final double windSpeed;
  final int date;
  final Sys sys;

  Weather({
    @required this.description,
    @required this.city,
    @required this.cityId,
    @required this.temperature,
    @required this.windSpeed,
    @required this.date,
    @required this.sys,
  });

  static List<Weather> parseList(List objectList) {
    List<Weather> list = [];
    for (Map object in objectList) list.add(Weather.parseMap(object));
    return list;
  }

  factory Weather.parseMap(Map object) {
    return Weather(
      description: object['weather'][0]['description'],
      city: object['name'],
      cityId: object['id'],
      temperature: Temperature.parseMap(object['main']),
      windSpeed: object['wind']['speed'].toDouble(),
      date: object['dt'],
      sys: Sys.parseMap(object['sys']),
    );
  }

  String get getTemperature {
    int temp = this.temperature.temp.round();
    String tempStr = '$temp';
    if (temp > 0) tempStr = '+$tempStr';
    if (temp < 0) tempStr = '-$tempStr';
    return tempStr;
  }

  String get getSunrise {
    // print(this.sys.sunrise)
    DateTime date = DateTime.parse('1970-01-01');
    date = date.add(Duration(seconds: this.sys.sunrise)).toLocal();
    return date.toString().split(' ')[1].substring(0, 5);
  }

  String get getSunset {
    DateTime date = DateTime.parse('1970-01-01');
    date = date.add(Duration(seconds: this.sys.sunset)).toLocal();
    return date.toString().split(' ')[1].substring(0, 5);
  }
}
