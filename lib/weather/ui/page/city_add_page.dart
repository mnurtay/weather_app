import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:weather_app/config.dart';
import 'package:weather_app/weather/bloc/weather_bloc.dart';
import 'package:weather_app/weather/flushbar.dart';

class CityAddPage extends StatefulWidget {
  @override
  _CityAddPageState createState() => _CityAddPageState();
}

class _CityAddPageState extends State<CityAddPage> {
  WeatherBloc weatherBloc;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    weatherBloc = WeatherBloc();
    super.initState();
  }

  @override
  void dispose() {
    weatherBloc.close();
    controller.dispose();
    super.dispose();
  }

  void onAddCity() {
    String city = controller.text;
    if (city.isEmpty) {
      FlushbarManager(
        context,
        message: 'Введите название города',
        title: 'Внимание!',
      ).show();
      return;
    }
    weatherBloc.add(AddCityWeatherEvent(city));
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
      body: BlocConsumer(
        cubit: weatherBloc,
        listener: (context, state) {
          if (state is FetchedWeatherState) Navigator.pop(context, true);
          if (state is NotFoundWeatherState) {
            FlushbarManager(
              context,
              message: 'Город не найден!',
              title: 'Ops!',
            ).show();
          }
        },
        builder: (context, state) {
          if (state is LoadingWeatherState) return buildLoading();
          if (state is FailureWeatherState) return buildFailure(state.error);
          return buildBody();
        },
      ),
    );
  }

  Widget buildBody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
              ),
              hintText: 'Название города',
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(30)),
          RaisedButton(
            onPressed: onAddCity,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
            ),
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(25),
              ),
              child: Text(
                'Добавить город',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget buildLoading() {
    String city = controller.text;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(80),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: ScreenUtil().setHeight(40)),
          Text(
            'Идёт поиск города $city',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              letterSpacing: -0.2,
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2,
      title: Text('Управление городами'),
    );
  }
}
