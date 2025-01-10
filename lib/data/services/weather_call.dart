import 'package:http/http.dart' as http;

class WeatherCall {
  WeatherCall({
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  final _client = http.Client();
  final String _apiKey = "ef7c7d0589a1ad4788889e69f23c57a1";

  Future<String> getWeatherData() async {
    final uri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey",
    );

    final response = await _client.get(uri);
    return response.body;
  }
}
