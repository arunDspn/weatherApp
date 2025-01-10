import 'package:http/http.dart' as http;

class GeocodeCall {
  GeocodeCall({
    required this.cityName,
    required this.stateCode,
    required this.countryCode,
  });

  final _client = http.Client();
  final String _apiKey = "ef7c7d0589a1ad4788889e69f23c57a1";
  final String cityName;
  final String stateCode;
  final String countryCode;

  Future<String> getGeoCode() async {
    final uri = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$cityName,$stateCode,$countryCode&appid=$_apiKey",
    );
    final response = await _client.get(uri);

    return response.body;
  }
}
