import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navbar.dart';
import '../widgets/info_card.dart';
import '../widgets/product_card.dart';
import '../providers/auth_provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import 'product_detail_screen.dart';

import 'products_screen.dart';
import 'schedule_screen.dart';
import 'admin_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIndex = 0;

  @override
  void initState() {
    super.initState();
    // garante carregamento no Web também
    Future.microtask(() {
      final p = Provider.of<ProductsProvider>(context, listen: false);
      if (p.items.isEmpty) p.loadSampleProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final products = Provider.of<ProductsProvider>(context).items;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FarmaTech"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'logout', child: Text('Sair')),
            ],
            onSelected: (value) {
              if (value == 'logout') Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0B8E7C), Color(0xFF18C1A3)]),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Olá, ${auth.usuario?.nome ?? 'Cliente'}",
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Sua farmácia digital — agende, compre e envie receitas.", style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 16),
          const InfoCard(icon: Icons.local_hospital, title: "Serviços 24h", text: "Atendimento rápido e seguro."),
          const InfoCard(icon: Icons.delivery_dining, title: "Entrega rápida", text: "Receba seus medicamentos em casa."),
          const InfoCard(icon: Icons.receipt_long, title: "Receitas digitais", text: "Envie receitas com facilidade."),
          const SizedBox(height: 20),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Recomendados", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (_, i) {
                final p = products[i];
                return ProductCard(
                  produto: p,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(produto: p))),
                  onAdd: () {
                    Provider.of<CartProvider>(context, listen: false).addProduct(p);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),

      // floating cart button (visível em qualquer tela)
      floatingActionButton: Stack(
        alignment: Alignment.topRight,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            child: const Icon(Icons.shopping_cart),
          ),
          if (cart.items.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text('${cart.items.length}', style: const TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavBar(
        currentIndex: navIndex,
        onTap: (index) {
          if (index == navIndex) return;
          if (index == 1) Navigator.pushReplacementNamed(context, '/products');
          if (index == 2) Navigator.pushReplacementNamed(context, '/schedule');
          if (index == 3) Navigator.pushReplacementNamed(context, '/admin');
        },
      ),
    );
  }
}
