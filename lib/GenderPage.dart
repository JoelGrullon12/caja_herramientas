import 'dart:convert';
import 'package:caja_herramientas/Apis.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var name;

  var imgName="void";



  Future checkGender() async{
    final response = await http.get(Uri.parse(Api.gender+name));
    Map<String, dynamic> json=jsonDecode(response.body);
    var gender=json['gender'];
    return gender;
  }

  changeImage(String img){
    setState(() {
      imgName=img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Verificar Genero",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Ingresa tu nombre',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu nombre';
                      }
                      return null;
                    },
                    onChanged: (String value){
                      setState(() {
                        name=value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("presionado");
                            checkGender().then((value) => changeImage(value));
                        }
                      },
                      child: const Text('Verificar Genero'),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset("images/"+imgName+".png"),
          ],
        )
      ),
    );
  }
}