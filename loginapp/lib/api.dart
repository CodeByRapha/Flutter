import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  String? value; // variável que vai armazenar o valor

  @override // precisa do override para subscrever o valor anterior
  void initState(){ // função que auxilia a resetar o estado da página toda vez que entrar nela.
  super.initState(); // super == sempre rodar esta função
  getvalue(); // função que busca o valor

  }

  void getvalue() async{
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));

    if(response.statusCode == 200){ // se o status da requisição for ok
      final data = jsonDecode(response.body); // json decode transforma as propriedades do json em tipos de dados

      setState(() {
        value = data[0]["title"];
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: value == null ? CircularProgressIndicator() : Text("$value"),
      ),
    );
  }
}