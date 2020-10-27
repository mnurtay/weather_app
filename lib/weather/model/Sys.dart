import 'package:flutter/material.dart';

class Sys {
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    @required this.country,
    @required this.sunrise,
    @required this.sunset,
  });

  factory Sys.parseMap(Map object) {
    return Sys(
      country: object['country'],
      sunrise: object['sunrise'],
      sunset: object['sunset'],
    );
  }

  Map toMap() {
    return {
      'country': this.country,
      'sunrise': this.sunrise,
      'sunset': this.sunset,
    };
  }
}

class ForecastCity {
  final int cityId;
  final String name;
  final String country;
  final int sunrise;
  final int sunset;

  ForecastCity({
    @required this.cityId,
    @required this.name,
    @required this.country,
    @required this.sunrise,
    @required this.sunset,
  });

  factory ForecastCity.parseMap(Map object) {
    return ForecastCity(
      cityId: object['id'],
      name: object['name'],
      country: object['country'],
      sunrise: object['sunrise'],
      sunset: object['sunset'],
    );
  }
}
