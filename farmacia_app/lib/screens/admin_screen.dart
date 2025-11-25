import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_navbar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int navIndex = 3;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    // bloqueia acesso para não-admins
    final isAdmin = auth.usuario?.nome == 'admin';

    if (!isAdmin) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Somente admin pode acessar.')));
        Navigator.pushReplacementNamed(context, '/home');
      });

      return const Scaffold(body: SizedBox.shrink());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Painel Admin")),
      body: const Center(child: Text("Área administrativa — Gerencie produtos, usuários e relatórios.")),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navIndex,
        onTap: (i) {
          if (i == navIndex) return;
          if (i == 0) Navigator.pushReplacementNamed(context, '/home');
          if (i == 1) Navigator.pushReplacementNamed(context, '/products');
          if (i == 2) Navigator.pushReplacementNamed(context, '/schedule');
        },
      ),
    );
  }
}
