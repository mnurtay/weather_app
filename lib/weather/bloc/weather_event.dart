part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {}

class GetForecastWeatherEvent extends WeatherEvent {
  final String city;
  GetForecastWeatherEvent(this.city);
}

class AddCityWeatherEvent extends WeatherEvent {
  final String city;
  AddCityWeatherEvent(this.city);
}
