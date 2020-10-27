import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/weather/bloc/weather_bloc.dart';
import 'package:weather_app/weather/ui/widget/weather_data.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = WeatherBloc();
    weatherBloc.add(GetWeatherEvent());
    super.initState();
  }

  @override
  void dispose() {
    weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(DEVICE_WIDTH, DEVICE_HEIGHT), allowFontScaling: true);

    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder(
        cubit: weatherBloc,
        builder: (context, state) {
          if (state is LoadingWeatherState) return buildLoading();
          if (state is FailureWeatherState) return buildFailure(state.error);
          if (state is FetchedWeathersState)
            return WeatherData(list: state.list);
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
      backgroundColor: Color(0xFF16697a),
      title: Text('Прогноз погоды'),
    );
  }
}
