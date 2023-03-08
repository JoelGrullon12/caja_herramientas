import 'dart:convert';

import 'package:caja_herramientas/Apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePage extends StatefulWidget {
  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var name, imgName="void", msgText="";

  Future<int> checkAge() async{
    final response=await http.get(Uri.parse(Api.age+name));
    Map<String, dynamic> json=jsonDecode(response.body);
    int age=json['age'];
    return age;
  }

  changeAge(int age){
    setState(() {
      if(age>=50){
        imgName="old";
        msgText="Eres viejo, tienes $age años";
      }else if(age<50 && age>30){
        imgName="adult";
        msgText="Eres un adulto, tienes $age años";
      }else{
        imgName="young";
        msgText="Eres muy joven, tienes $age años";
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Calcular edad",
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
                          checkAge().then((value) => changeAge(value));
                        }
                      },
                      child: const Text('Calcular Edad'),
                    ),
                  ),
                  Image.asset("images/$imgName.png"),
                  Text(msgText)
                ],
              ),
            ),
          ],
        )
    );
  }
}