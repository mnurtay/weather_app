part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class LoadingWeatherState extends WeatherState {}

class FailureWeatherState extends WeatherState {}

class FetchedWeatherState extends WeatherState {}
