import 'package:flutter/material.dart';

import 'networking.dart';
import 'location.dart';
const apiKey = 'cf7c756f5e12227d1d5a86897726c479';
const openWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
 Future<dynamic> getCityWeather(String cityname)async{
   NetworkHelper networkHelper=NetworkHelper
     ('$openWeatherMapUrl?q=$cityname&appid=$apiKey&units=metric');
   var weatherData= await networkHelper.getData();
   return weatherData;
 }
  Future<dynamic> getLocationWeather()async{
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkhelper.getData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}