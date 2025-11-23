import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_pharmacy, size: 80, color: Colors.teal),
              const SizedBox(height: 20),
              const Text("FarmaTech", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              TextField(controller: nomeController, decoration: const InputDecoration(labelText: "Usuário")),
              const SizedBox(height: 14),
              TextField(controller: senhaController, obscureText: true, decoration: const InputDecoration(labelText: "Senha")),
              const SizedBox(height: 20),

              if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),

              ElevatedButton(
                onPressed: () {
                  final ok = auth.login(nomeController.text.trim(), senhaController.text);
                  if (ok) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                  } else {
                    setState(() => error = "Usuário ou senha incorretos.");
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                child: const Text("Entrar"),
              ),

              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: const Text("Criar conta"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
