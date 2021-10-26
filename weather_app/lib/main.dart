import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectLoc = "Changlun";
  List<String> locList = [
    "Changlun",
    "Jitra",
    "Alor Setar",
    "Baling",
  ];
  String desc = "No record";
  var temp = 0.0, hum = 0, weather = "", feels_like = 0.0;
  Weather curweather = Weather("Not Available", 0.0, 0, "Not Available", 0.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Simple Weather App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            itemHeight: 60,
            value: selectLoc,
            onChanged: (newValue) {
              setState(() {
                selectLoc = newValue.toString();
              });
            },
            items: locList.map((selectLoc) {
              return DropdownMenuItem(
                child: Text(
                  selectLoc,
                ),
                value: selectLoc,
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: _loadWeather, child: const Text("Load Weather")),
          Expanded(
            child: Weathergrid(
              curweather: curweather,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadWeather() async {
    var apiid = "15de80e1abffb64ec7d59b4432709513";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectLoc&appid=$apiid&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      temp = parsedJson['main']['temp'];
      hum = parsedJson['main']['humidity'];
      weather = parsedJson['weather'][0]['main'];
      feels_like = parsedJson['main']['feels_like'];
      curweather = Weather(selectLoc, temp, hum, weather, feels_like);
      setState(() {
        desc =
            "The current weather in $selectLoc is $weather. The current temperature is $temp Celcius and humidity is $hum percent. ";
      });
    } else {
      print("Failed");
    }
  }
}

class Weathergrid extends StatefulWidget {
  final Weather curweather;
  const Weathergrid({Key? key, required this.curweather}) : super(key: key);

  @override
  _WeathergridState createState() => _WeathergridState();
}

class _WeathergridState extends State<Weathergrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          GestureDetector(
            onTap: _pressMe,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Location"),
                    const Icon(
                      Icons.location_city,
                      size: 64,
                    ),
                    Text(widget.curweather.loc)
                  ],
                ),
                color: Colors.blue[100],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Weather"),
                const Icon(
                  Icons.cloud,
                  size: 64,
                ),
                Text(widget.curweather.weather)
              ],
            ),
            color: Colors.blue[100],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Temp"),
                const Icon(
                  Icons.thermostat,
                  size: 64,
                ),
                Text(widget.curweather.temp.toString() + " Celcius")
              ],
            ),
            color: Colors.blue[100],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Humidity"),
                const Icon(
                  Icons.hot_tub,
                  size: 64,
                ),
                Text(widget.curweather.hum.toString() + "%")
              ],
            ),
            color: Colors.blue[100],
          ),
           Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Feels like"),
                const Icon(
                  Icons.thermostat_auto,
                  size: 64,
                ),
                Text(widget.curweather.feels_like.toString() + "celcius")
              ],
            ),
            color: Colors.blue[100],
          ),
        ]);
  }

  void _pressMe() {
    print("Hello");
  }
}
