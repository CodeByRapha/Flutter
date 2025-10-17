import 'package:flutter/material.dart';

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          scrollDirection: Axis.horizontal, //indica que a rolagem será ma horizontal
          children: [
            Row(
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
      ),
    );
  }
}