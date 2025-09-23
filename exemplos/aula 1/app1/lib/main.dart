import 'package:flutter/material.dart';

void main() {
  runApp(const Home()); // runApp é a função responsável por rodar o app.
}

class Home extends StatelessWidget { //Tela estática, digite "st" para sekecionar o tipo de tela.
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //prover os elementos para a sua tela.
      home: Scaffold( // Separa a tela em 2 partes. Barra superior e conteúdo.
            appBar: AppBar(title: Text("Olá, bem-vindo Campeão!")),
            body:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ //filhos coluna
                Container(
                width: MediaQuery.of(context).size.width * 0.2, //porcentagem
                height: 50, //pixels
                decoration: BoxDecoration(
                  color: Color(0XFF9238439),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Text("Olá",
                style: TextStyle(fontSize: 35, color:Colors.white ),
                textAlign: TextAlign.center
                ),
                // forma hexadecimal: Color(0XFF9238439), 0X é obrigatótio
                // forma mais simples: Colors.blue,
                ),
                Container(
                width: MediaQuery.of(context).size.width * 0.2, //porcentagem
                height: 50, //pixels
                color: Color(0xF83EECDE) ,
                // forma hexadecimal: Color(0XFF9238439), 0X é obrigatótio
                // forma mais simples: Colors.blue,
                ),
                Container(
                width: MediaQuery.of(context).size.width * 0.2, //porcentagem
                height: 50, //pixels
                color: Color(0xF83AA8DB) ,
                // forma hexadecimal: Color(0XFF9238439), 0X é obrigatótio
                // forma mais simples: Colors.blue,
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xFFFF38FF),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xFFC659E7),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: const Color(0xFFF321A3),
                  ),
                  ],
                )
              ],

            ),
           
      )
    );
  }
}