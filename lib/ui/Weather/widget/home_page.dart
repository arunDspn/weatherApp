import 'package:flutter/material.dart';
import 'package:weather_app/data/repositories/weather_repository_remote.dart';
import 'package:weather_app/domain/models/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String jsonData = '';
  late Weather weather;
  final _formKey = GlobalKey<FormState>();
  String cityName = '';
  String stateCode = '';
  String countryCode = '';
  late int lat;
  late int long;

  getData() async {
    final geoData = await WeatherRepositoryRemote().getGeoCode(
        cityName: cityName, countryCode: countryCode, stateCode: stateCode);

    weather = await WeatherRepositoryRemote()
        .fetchWeatherData(lat: (geoData.lat), lon: (geoData.lon));

    print(weather);
    setState(() {
      isLoading = false;
    });
  }

  void onSubmit() {
    _formKey.currentState!.save();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("City Code"),
                      ),
                      onSaved: (newValue) {
                        cityName = newValue!;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("State Code"),
                            ),
                            onSaved: (newValue) {
                              stateCode = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Country Code"),
                            ),
                            onSaved: (newValue) {
                              countryCode = newValue!;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.sunny),
                label: const Text("Get weather data"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 130, 81, 139)),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? const Text("No data loaded")
                    : Text(weather.toString()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
