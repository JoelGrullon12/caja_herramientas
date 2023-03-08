import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Acerca De",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20,),
          Image.asset("images/personal.jpg"),
          SizedBox(height: 15,),
          Text(
            "Joel Grullon",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "joelenmanuelgm@gmail.com",
            style: Theme.of(context).textTheme.bodyText2,
          ),

        ],
      )
    );
  }
}