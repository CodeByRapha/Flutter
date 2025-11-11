import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  //Aqui fica a sua lógica 
  //Variavel que "observa" o que o usuario digita, o famoso fofoqueiro 👅👀
  TextEditingController novatemperatura = TextEditingController();

  @override 
  void initState(){ //funcao que reinicia o estado da pagina.
  super.initState();
  mensagem = "";
  erro = "";
  }
  
  String erro = ""; //variavel para erro 
  String mensagem = "" ; //variavel para alertar que deu certo 
  
  //Funcao Post 
  //Future, porque a confirmacao acontece no futuro 
  Future<void> postValue() async {
    //Crio uma instancia do banco , na coleção monitoramento e adiciono algo 
    
    try{
       FirebaseFirestore.instance.collection("monitoramento").add(
      {
        "temperatura": novatemperatura.text, 
      }
    );

    setState(() {
      mensagem = "Dados enviados com sucesso";
    });

    Timer(Duration(seconds: 4), (){
      setState(() {
        mensagem = "";
      });
    });
    

  
    }catch(e){
      setState(() {
        erro = "Erro ao enviar dados";
      });
    }
  }



  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Post Page")),
        body: Center(
          child: Column(
            children: [
              Text("Insira a sua temperatura"),
              TextField(
                controller: novatemperatura,
              ),
              ElevatedButton(onPressed:postValue, child: Text("Inserir dados no banco!")),
              Text("$mensagem"), 
              Text("$erro")
            ],
          ),
        )

      )
    );
  }
}