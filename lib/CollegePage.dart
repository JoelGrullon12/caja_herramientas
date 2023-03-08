import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Apis.dart';

class CollegePage extends StatefulWidget {
  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _firstController = ScrollController();

  var country, imgName="void", msgText="";
  List<dynamic> unis=[];

  Future findColleges() async{
    final response=await http.get(Uri.parse(Api.college+country));
    List<dynamic> json=jsonDecode(response.body);
    print(json);
    return json;
  }

  loadColleges(var data){
    setState(() {
      unis=data;
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
                    "Universidades",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Ingresa el nombre de un pais en ingles',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa algun pais en ingles';
                      }
                      return null;
                    },
                    onChanged: (String value){
                      setState(() {
                        country=value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          findColleges().then((value) => loadColleges(value));
                        }
                      },
                      child: const Text('Buscar Universidades'),
                    ),
                  ),
                ],
              ),
            ),
            Scrollbar(
              thumbVisibility: true,
              controller: _firstController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(var uni in unis)
                    Card(
                      color: Theme.of(context).colorScheme.surface,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            uni['name'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "Dominio principal: "+uni['domains'][0],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            uni['web_pages'][0],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        )
    );
  }
}