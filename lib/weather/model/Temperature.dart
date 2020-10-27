import 'package:flutter/material.dart';

class Temperature {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double humidity;

  Temperature({
    @required this.temp,
    @required this.feelsLike,
    @required this.tempMin,
    @required this.tempMax,
    @required this.pressure,
    @required this.humidity,
  });

  factory Temperature.parseMap(Map object) {
    return Temperature(
      temp: object['temp'].toDouble(),
      feelsLike: object['feels_like'].toDouble(),
      tempMin: object['temp_min'].toDouble(),
      tempMax: object['temp_max'].toDouble(),
      pressure: object['pressure'].toDouble(),
      humidity: object['humidity'].toDouble(),
    );
  }

  Map toMap() {
    return {
      'temp': this.temp,
      'feels_like': this.feelsLike,
      'temp_min': this.tempMin,
      'temp_max': this.tempMax,
      'pressure': this.pressure,
      'humidity': this.humidity,
    };
  }
}
