
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:weatherflutter/WeatherData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// The below request is the same as above.
/*
 response = await dio.get( '/test',queryParameters: {'id': 12, 'name': 'dio'},);
 response = await dio.post('/test', data: {'id': 12, 'name': 'dio'});
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<MyHomePage> {


 late double latitude = 0.0;
 late double longtitude= 0.0;

  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: TextButton(onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context){
          //  return Screen2();
          // }));
        }, child: Text( ""),),
      ),
      body: Column(
          children:[
          SpinKitDoubleBounce(
            color: Colors.yellow,
            size: 100,
          ),
          Text(weatherData!.main.temp.toString())
        ]));
  }



 Future<void> getCurrentLocation()
 async {
   try {
     LocationPermission permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       print("No permission, requesting one");
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.deniedForever) {
         return Future.error('Location Not Available');
       }
     }
     print("Found permission to get location");
     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.low);
     latitude = position.latitude;
     longtitude = position.longitude;
     print("$latitude + $longtitude");
     getData(latitude,longtitude);
   } catch (e) {
     print(e);
   }
   getData(latitude,longtitude);

 }


 void getData(var lat, var lon) async {
   final dio = Dio();
   var url='https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=18aef7b2c2b6f3511b271fe76ac9b295';
   Response response = await dio.get(url);
   print("vijay : "+url );

   if(response.statusCode==200)
     {
       print("vijay = ${response.data}");
       weatherData =  WeatherData.fromJson(response.data);
       print("chauhan${weatherData?.main.temp}");

       setState(() {
       });}
     }

}
