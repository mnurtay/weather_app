import 'package:flutter/material.dart';
import 'package:weather_app/weather/ui/page/forecast_page.dart';
import 'package:weather_app/weather/ui/page/weather_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (settings) {
        Widget page = Scaffold();
        if (settings.name == '/') page = WeatherPage();
        if (settings.name == '/detail')
          page = ForecastPage(weather: settings.arguments);
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}
