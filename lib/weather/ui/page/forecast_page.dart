import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/weather/bloc/weather_bloc.dart';
import 'package:weather_app/weather/model/Weather.dart';
import 'package:weather_app/weather/ui/widget/forecast_data.dart';

class ForecastPage extends StatefulWidget {
  final Weather weather;

  const ForecastPage({Key key, @required this.weather}) : super(key: key);
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  Weather get weather => widget.weather;
  WeatherBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = WeatherBloc();
    weatherBloc.add(GetForecastWeatherEvent(weather.city));
    super.initState();
  }

  @override
  void dispose() {
    weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var width = DEVICE_WIDTH;
    var height = DEVICE_HEIGHT;
    if (shortestSide > 600) {
      width = TABLET_WIDTH;
      height = TABLET_HEIGHT;
    }
    ScreenUtil.init(context,
        designSize: Size(width, height), allowFontScaling: true);

    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder(
        cubit: weatherBloc,
        builder: (context, state) {
          if (state is LoadingWeatherState) return buildLoading();
          if (state is FailureWeatherState) return buildFailure(state.error);
          if (state is FetchedForecastState)
            return ForecastData(
                weather: weather, forecastList: state.forecastList);
          return Container();
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildFailure(String error) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40)),
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(32),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2,
      title: Text(weather.city),
    );
  }
}
