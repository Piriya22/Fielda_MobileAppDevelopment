import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather {
  final int? max;
  final int? min;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidity;
  final int? chanceRain;
  final String? image;
  final String? time;
  final String? location;

  Weather(
      {this.max,
      this.min,
      this.name,
      this.day,
      this.wind,
      this.humidity,
      this.chanceRain,
      this.image,
      this.current,
      this.time,
      this.location});
}

String appId = "2931ce15bce6c867358aeed5c3610677";

Future<List<Weather>> fetchData(String lat, String lon) async {
  var url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    var mainData = res["main"];
    var weatherData = res["weather"][0];
    var windData = res["wind"];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(now);

    Weather currentTemp = Weather(
      current: mainData["temp"]?.round(),
      name: weatherData["main"]?.toString(),
      day: formattedDate,
      wind: windData["speed"]?.round(),
      humidity: mainData["humidity"]?.round(),
      location: res["name"]?.toString(),
      image: "assets/cloud.png",
    );

    List<Weather> todayWeather = [];
    for (var i = 0; i < 4; i++) {
      var mDate = DateFormat('hh:mm a').format(now);
      var hourOnly = now.hour;
      var minutesOnly = now.minute;
      var hourly = Weather(
        current: mainData["temp"]?.round() ?? 0,
        image: "assets/cloud.png",
        time: "$hourOnly : $minutesOnly",
      );
      todayWeather.add(hourly);
    }

    return [currentTemp];
  }

  return [];
}

List<Weather> todayWeather = [
  Weather(current: 23, image: "assets/cloud.png", time: "11:00"),
  Weather(current: 23, image: "assets/cloud.png", time: "11:00"),
  Weather(current: 23, image: "assets/cloud.png", time: "11:00"),
  Weather(current: 23, image: "assets/cloud.png", time: "11:00"),
];

Weather tomorrowTemp = Weather(
  max: 23,
  min: 34,
  image: "assets/cloud.png",
  name: "sunny",
  wind: 7,
  humidity: 31,
  chanceRain: 45,
);

List<Weather>? sevenDay = [
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Mon",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Tue",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Wed",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Thu",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Fri",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Sat",
    name: "snow",
  ),
  Weather(
    max: 23,
    min: 45,
    image: "assets/snow.png",
    day: "Sun",
    name: "snow",
  )
];
