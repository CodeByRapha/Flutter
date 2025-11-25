import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Criar conta")),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: "Nome")),
            const SizedBox(height: 16),
            TextField(controller: senhaController, obscureText: true, decoration: const InputDecoration(labelText: "Senha")),
            const SizedBox(height: 18),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      setState(() {
                        loading = true;
                        error = null;
                      });
                      final ok = await auth.register(nomeController.text.trim(), senhaController.text);
                      setState(() => loading = false);
                      if (ok) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                      } else {
                        setState(() => error = "Usuário já existe.");
                      }
                    },
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()) : const Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
