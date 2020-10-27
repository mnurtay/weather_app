import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/weather/model/ForecastList.dart';
import 'package:weather_app/weather/model/Weather.dart';

class ForecastData extends StatefulWidget {
  final Weather weather;
  final ForecastList forecastList;

  const ForecastData({
    Key key,
    @required this.weather,
    @required this.forecastList,
  }) : super(key: key);
  @override
  _ForecastDataState createState() => _ForecastDataState();
}

class _ForecastDataState extends State<ForecastData> {
  Weather get weather => widget.weather;
  ForecastList get forecastList => widget.forecastList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(70)),
            buildDescription(),
            SizedBox(height: ScreenUtil().setHeight(100)),
            buildGeneral(),
            SizedBox(height: ScreenUtil().setHeight(100)),
            buildForecastList(),
            SizedBox(height: ScreenUtil().setHeight(70)),
          ],
        ),
      ),
    );
  }

  Widget buildForecastList() {
    List<Widget> children = [];
    for (var item in forecastList.list) children.add(buildForecast(item));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: children),
    );
  }

  Widget buildForecast(Forecast forecast) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(60),
      ),
      child: Column(
        children: [
          Text(
            forecast.getDate,
            style: TextStyle(
              color: Colors.white.withOpacity(forecast.isNewDay ? 0.85 : 0.7),
              fontWeight: forecast.isNewDay ? FontWeight.w600 : FontWeight.w400,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Text(
            forecast.getTemperature,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: ScreenUtil().setSp(35),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(12)),
          Text(
            '${forecast.windSpeed} м/сек',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGeneral() {
    return Container(
      width: ScreenUtil().setWidth(DEVICE_WIDTH),
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(50),
        vertical: ScreenUtil().setHeight(40),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
      ),
      child: Column(
        children: [
          buildSun(),
          SizedBox(height: ScreenUtil().setHeight(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTemp(),
              buildHumidity(),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildWindSpeed(),
              Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWindSpeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Скорость ветра',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(
          '${weather.windSpeed} м/cек',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
      ],
    );
  }

  Widget buildHumidity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Влажность',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(
          '${weather.temperature.humidity.round()}%',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
      ],
    );
  }

  Widget buildTemp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ощущается',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(
          '${weather.temperature.temp.toStringAsFixed(1)}˚C',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(40),
          ),
        ),
      ],
    );
  }

  Widget buildSun() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Восход ${weather.getSunrise}',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
        Text(
          'Закат ${weather.getSunset}',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          Text(
            weather.getTemperature,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(120),
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Text(
            weather.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(36),
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w300,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}
