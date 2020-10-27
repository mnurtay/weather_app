import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/weather/model/Weather.dart';

class WeatherData extends StatefulWidget {
  final List<Weather> list;

  const WeatherData({Key key, @required this.list}) : super(key: key);
  @override
  _WeatherDataState createState() => _WeatherDataState();
}

class _WeatherDataState extends State<WeatherData> {
  List<Weather> get list => widget.list;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(SizedBox(height: ScreenUtil().setHeight(50)));
    for (var item in list) children.add(buildWeatherItem(item));
    children.add(SizedBox(height: ScreenUtil().setHeight(50)));

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(30),
      ),
      child: SingleChildScrollView(
        child: Column(children: children),
      ),
    );
  }

  Widget buildWeatherItem(Weather weather) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(15),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(12)),
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: weather);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(40),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.city,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        letterSpacing: -0.1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    Text(weather.description),
                  ],
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
              Text(
                weather.getTemperature,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
