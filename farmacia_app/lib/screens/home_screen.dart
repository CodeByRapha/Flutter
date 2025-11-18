import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'admin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FarmaTech"),
        actions: [
          PopupMenuButton(
            onSelected: (v) {
              if (v == "logout") auth.logout();
              if (v == "admin") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AdminScreen()));
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: "admin", child: Text("Admin")),
              PopupMenuItem(value: "logout", child: Text("Sair")),
            ],
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---------------------------
          // BANNER
          // ---------------------------
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0B8E7C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Bem-vindo à FarmaTech!\nSeu app de medicamentos, agenda e receitas!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          const SizedBox(height: 20),

          // ---------------------------
          // CARDS DE INFORMAÇÃO
          // ---------------------------
          const Text("Serviços disponíveis",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Row(
            children: [
              _infoCard(Icons.medication, "Medicamentos"),
              const SizedBox(width: 12),
              _infoCard(Icons.schedule, "Agendamentos"),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _infoCard(Icons.receipt_long, "Receitas"),
              const SizedBox(width: 12),
              _infoCard(Icons.support_agent, "Atendimento"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(1, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: Color(0xFF0B8E7C)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
