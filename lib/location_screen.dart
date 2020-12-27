import 'package:flutter/material.dart';
import 'constants.dart';
import 'weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather =WeatherModel();
  int temprature;
  String weatherIcon;
  String cityname;
  String weatherMessage;

  @override
  void initState() {

    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if(weatherData==null){
        temprature=0;
        weatherIcon='ERROR';
        weatherMessage='Unable to get the data';
        cityname='';
        return;
      }
      double temp = weatherData['main']['temp'];
      temprature=temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon =weather.getWeatherIcon(condition);
      cityname = weatherData['name'];
      weatherMessage =weather.getMessage(temprature);
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage('assets/images/image1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),*/
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData =await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                        var typedname=await Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CityScreen();
                        }));
                        if(typedname!=null){
                      var weatherData= await weather.getCityWeather(typedname);
                      updateUI(weatherData);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temprature;
  int condition;
  String cityname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    double temp = weatherData['main']['temp'];
    temprature=temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityname = weatherData['name'];
    print(temprature);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/
