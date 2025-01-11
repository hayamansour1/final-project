import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Faild to load weather data');
    }
  }

  Future<String> getCurrentCity() async{
    
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermisson();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermissin();
    }

    //fetch the current location 
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoorinates(position.latitude, position.longitude);
        
    //extract the city name from the first placemark
    string? city = placemarks[0].locality;
    return city ?? "";
  }
}