import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      try {
        await _repository.getWeather();
        yield FetchedWeatherState();
      } catch (e) {
        yield FailureWeatherState();
      }
    }
  }
}
