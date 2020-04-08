import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  void getLocation () async {

    Location location = Location();
    await location.getCurrentLocation();
    print("In loading screen");
    print(location.longitude);
    print(location.latitude);


  }

  void getDataFromWeatherAPI() async {
    // https://developers.google.com/books/docs/overview
    var url = 'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22';

    // Await the http get response, then decode the json-formatted response.
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      final decodedData = jsonDecode(data);
      final  weatherCondition = decodedData['weather'][0]['description'];
      final  temperature = decodedData['main']['temp'];
      final  condition = decodedData['weather'][0]['id'];
      final  name = decodedData['name'];

      print(name);

      print (weatherCondition);
    }else
       print( 'Error with response object ${response.body}');
  }


  @override
  Widget build(BuildContext context) {
    getDataFromWeatherAPI();
    return Scaffold();
  }
}
