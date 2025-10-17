import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget{
  const TelaHome({super.key});

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(  // permite a rolagem de tela
          children: [
           Column(
            children: [
              Container(
                width: 400,
                height: 600,
                color: Colors.blue.shade700,
              ),
              Container(
                width: 400,
                height: 600,
                color:Colors.purple,
              ),
              Container(
                width: 400,
                height: 600,
                color: Colors.purple.shade300,
              ),
              Container(
                width: 400,
                height: 600,
                color: Colors.pink.shade300,
              )
            ],
           )
          ],

        ),
      )
    );
  }
}