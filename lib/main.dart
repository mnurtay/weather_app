import 'package:flutter/material.dart';
import 'package:weather_app/weather/ui/page/city_add_page.dart';
import 'package:weather_app/weather/ui/page/forecast_page.dart';
import 'package:weather_app/weather/ui/page/weather_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: MaterialApp(
        title: 'Weather app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF00587a),
          accentColor: Color(0xFF00587a),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          Widget page = Scaffold();
          if (settings.name == '/') page = WeatherPage();
          if (settings.name == '/detail')
            page = ForecastPage(weather: settings.arguments);
          if (settings.name == '/add_page') page = CityAddPage();
          return MaterialPageRoute(builder: (context) => page);
        },
      ),
    );
  }
}
