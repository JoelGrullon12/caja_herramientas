import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:caja_herramientas/Apis.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var imgUrl="https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png";
  var msgText="";

  Future<dynamic> checkWeather() async{
    final response=await http.get(Uri.parse(Api.weather));
    Map<String, dynamic> json=jsonDecode(response.body);
    dynamic data={
      "img":json['current']['condition']['icon'],
      "condition":json['current']['condition']['text']
    };

    return data;
  }

  loadWeather(dynamic data){
    setState(() {
      imgUrl=data['img'];
      msgText=data['condition'];
    });
  }

  @override
  Widget build(BuildContext context) {
    checkWeather().then((value) => loadWeather(value));

    return Center(
        child: Column(
          children: [
            Text(
              "Clima en Santo Domingo",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Image.network("http:"+imgUrl),
            Text(
              msgText,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        )
    );
  }
}