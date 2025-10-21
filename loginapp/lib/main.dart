import 'package:flutter/material.dart';
import 'package:loginapp/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false, // tira o banner de debug
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variável que observa o que o usuário digita
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  // Variáveis para logar
  String correctUser = "rapha";
  String correctPassword = "123";

  // Variável para mostrar a mensagem do erro
  String erro = "";

  void login() {
    if (user.text == correctUser && password.text == correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ApiPage()),
      );
    } else {
      setState(() {
        erro = "Existem credenciais erradas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 120,
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 20),

              TextField(
                // Campo para o usuário digitar suas informações
                controller: user,
                decoration: InputDecoration(
                  hintText: "Insira o seu nome",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: password,
                obscureText: true, // senha privada ********/
                decoration: InputDecoration(
                  hintText: "Insira sua senha",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "$erro",
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
