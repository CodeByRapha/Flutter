import 'package:appnavbar/home.dart';
import 'package:appnavbar/tela2.dart';
import 'package:appnavbar/tela3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavBar());
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0; //variável indíce atual

  void changeIndex(int index) { // função para mudar o indíce
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    TelaHome(),
    Tela2(),
    Tela3()

  ]; // lista que contem todas as nossas telas

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //prove os componentes para a sua tela
    home: Scaffold(
      body: screens.elementAt(currentIndex), // O conteúdo será a tela que está o index atual
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(label: "Tela 1", icon: Icon(Icons.account_circle)),
        BottomNavigationBarItem(label: "Tela 2", icon: Icon(Icons.account_circle)),
        BottomNavigationBarItem(label: "Tela 3", icon: Icon(Icons.account_circle))

      ],
      currentIndex: currentIndex, // a posição desejada
      onTap: changeIndex, //função que muda o index

      
      )
      
      ),

    );
  }
}
