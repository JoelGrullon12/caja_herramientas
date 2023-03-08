import 'package:caja_herramientas/AboutPage.dart';
import 'package:caja_herramientas/AgePage.dart';
import 'package:caja_herramientas/CollegePage.dart';
import 'package:caja_herramientas/GenderPage.dart';
import 'package:caja_herramientas/HomePage.dart';
import 'package:caja_herramientas/WeatherPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToolBox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});


  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedIndex=0;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch(selectedIndex){
      case 0:
        page=HomePage();
        break;

      case 1:
        page=GenderPage();
        break;

      case 2:
        page=AgePage();
        break;

      case 3:
        page=CollegePage();
        break;

      case 4:
        page=WeatherPage();
        break;

      case 5:
        page=AboutPage();
        break;


      default:
        throw UnimplementedError('No existe una pantalla con el indice $selectedIndex');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Toolbox'),
            ),
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth>=600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Inicio'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.transgender),
                        label: Text('Genero'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.access_time),
                        label: Text('Edad'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.school),
                        label: Text('Universidades'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.cloud),
                        label: Text('Clima'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.question_mark),
                        label: Text('Acerca De'),
                      ),

                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (index){
                      setState(() {
                        selectedIndex=index;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                        color: Theme.of(context).colorScheme.background,
                        child: page
                    ),
                ),
              ],
            ),
          );
        }
    );
  }
}
