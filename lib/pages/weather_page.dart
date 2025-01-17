import 'package:final_project/models/weather_model.dart';
import 'package:final_project/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('0bee87a0c79e2fb0abcbb9c278b6a251');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition){
    //defult to sunny
    if (mainCondition == null) return 'assets/animations/sunny.json';

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animations/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rainy.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      case 'clear':
        return 'assets/animations/sunny.json';

      default:
        return 'assets/animations/sunny.json';
    }
    
  }

  //init state
  @override
  void initState(){
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_weather?.cityName ?? "Loading city.."),

            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
        
            //temperature
            Text('${_weather?.temperature.round()}°C'),

            //weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}