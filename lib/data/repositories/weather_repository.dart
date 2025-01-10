import 'package:weather_app/domain/models/geo_location.dart';
import 'package:weather_app/domain/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeatherData({
    required double lat,
    required double lon,
  });

  Future<GeoLocation> getGeoCode({
    required String cityName,
    required String stateCode,
    required String countryCode,
  });
}
