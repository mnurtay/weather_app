part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class FailureWeatherState extends WeatherState {
  final String error;
  FailureWeatherState(this.error);
}

class FetchedWeathersState extends WeatherState {
  final List<Weather> list;
  FetchedWeathersState(this.list);
}

class FetchedForecastState extends WeatherState {
  final ForecastList forecastList;
  FetchedForecastState(this.forecastList);
}

class NotFoundWeatherState extends WeatherState {}

class FetchedWeatherState extends WeatherState {}
