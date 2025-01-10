import 'dart:convert';

import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/models/geo_location.dart';
import 'package:weather_app/domain/models/weather.dart';

import 'package:http/http.dart' as http;

class WeatherRepositoryRemote implements WeatherRepository {
  static const String _apiKey = "ef7c7d0589a1ad4788889e69f23c57a1";

  @override
  Future<Weather> fetchWeatherData({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey",
    );

    final response = await http.get(uri);

    /// purpose of [[weatherFromJson]]
    // Else we need this
    // return Weather.fromJson(json.decode(response.body));
    return weatherFromJson(response.body);
  }

  @override
  Future<GeoLocation> getGeoCode({
    required String cityName,
    required String stateCode,
    required String countryCode,
  }) async {
    final uri = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$cityName,$stateCode,$countryCode&appid=$_apiKey",
    );
    final response = await http.get(uri);
    final data = json.decode(response.body);

    return GeoLocation(lat: data[0]['lat'], lon: data[0]['lon']);
  }
}
