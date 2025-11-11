import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  //Aqui voce coda a logica 
  List<dynamic>? valores; //lista que ira receber os dados do banco 

  @override 
  void initState(){//reiniciar a pagina 
  super.initState();
  getValues(); 
  }

  void getValues () async {
    //Crio uma instancia do firebase na colecao monitoramento 
    // os retornos (snapshots) --> instantaneo 
    //ouvir /listar os retornos(listen)

    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshots){
        final data = snapshots.docs; //variavel que contem todos os registros do banco 
        setState(() {
          valores = data;
        });
      }
    );

  }
  //Funcao futura pois a validação acontece depois da requisição no APP. 
  //Precisa receber um id para deletar o documento == registro 
  //Id no Firebase sempre é String . Exemplo: "892323gasdasfdgah!#"
  Future<void> deleteValue (String id) async {
    FirebaseFirestore.instance.collection("monitoramento").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de Delete")),
        body:valores == null ? Center(child: CircularProgressIndicator(),) :
        ListView.builder(
          itemCount: valores!.length , //Quantos itens irei criar? R: O tamanho da lista valores.
          itemBuilder:(context, index){ //O que irei criar ? 
              final item = valores![index];
              
              return ListTile(
                title: Text("Temperatura"),
                subtitle: Text("${item["temperatura"]}"),
                trailing: GestureDetector( //Detecta um gesto e attribui uma função para um ícone por exemplo
                  child: Icon(Icons.remove),
                  onTap: (){
                    deleteValue(item.id);
                  },
                ),

              );

          } , 
        )
      )
    );
  }
}