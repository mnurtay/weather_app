import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/weather/model/ForecastList.dart';
import 'package:weather_app/weather/model/Weather.dart';
import 'package:weather_app/weather/resource/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());
  WeatherRepository _repository = WeatherRepository();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherEvent) {
      yield LoadingWeatherState();
      List objectList = await _repository.getWeathers();
      List<Weather> list = Weather.parseList(objectList);
      try {
        if (list.isEmpty) {
          await _repository.fetchWeather('Москва');
          await _repository.fetchWeather('Санкт-Петербург');
          objectList = await _repository.getWeathers();
          list = Weather.parseList(objectList);
        }
        yield FetchedWeathersState(list);
        await _repository.updateAll();
        objectList = await _repository.getWeathers();
        list = Weather.parseList(objectList);
        yield WeatherInitial();
        yield FetchedWeathersState(list);
      } catch (e) {
        if (list.isEmpty) yield FailureWeatherState(e.toString());
      }
    }
    if (event is GetForecastWeatherEvent) {
      yield LoadingWeatherState();
      ForecastList forecast = await _repository.getForcastWeather(event.city);
      try {
        if (forecast == null) {
          await _repository.fetchWeather(event.city);
          forecast = await _repository.getForcastWeather(event.city);
        }
      } catch (e) {
        yield FailureWeatherState(e.toString());
      }
      yield FetchedForecastState(forecast);
    }
  }
}
