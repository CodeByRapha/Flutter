import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_navbar.dart';
import '../widgets/info_card.dart';
import '../widgets/product_card.dart';
import '../providers/auth_provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

import 'products_screen.dart';
import 'schedule_screen.dart';
import 'admin_screen.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

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

    // divide pages: cada página mostra 10 itens (5x2)
    final perPage = 10;
    final pageCount = (products.length / perPage).ceil();
    final pages = List.generate(pageCount, (pageIndex) {
      final start = pageIndex * perPage;
      final end = (start + perPage).clamp(0, products.length);
      final slice = products.sublist(start, end);
      return slice;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("FarmaTech"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) =>
                const [PopupMenuItem(value: 'logout', child: Text('Sair'))],
            onSelected: (v) {
              if (v == 'logout') {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B8E7C), Color(0xFF18C1A3)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Olá, ${auth.usuario?.nome ?? 'Cliente'}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sua farmácia digital — agende, compre e envie receitas.",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const InfoCard(
              icon: Icons.local_hospital,
              title: "Serviços 24h",
              text: "Atendimento rápido e seguro."),
          const InfoCard(
              icon: Icons.delivery_dining,
              title: "Entrega rápida",
              text: "Receba seus medicamentos em casa."),
          const InfoCard(
              icon: Icons.receipt_long,
              title: "Receitas digitais",
              text: "Envie receitas com facilidade."),

          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Recomendados",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),

          // ----------------------------
          //      CARROSSEL + GRID RESPONSIVO
          // ----------------------------
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;

              // número automático de colunas baseado na largura
              int crossAxis;
              if (screenWidth < 500) {
                crossAxis = 2;
              } else if (screenWidth < 800) {
                crossAxis = 3;
              } else if (screenWidth < 1100) {
                crossAxis = 4;
              } else if (screenWidth < 1500) {
                crossAxis = 5;
              } else {
                crossAxis = 6;
              }

              // largura de cada card
              final spacing = 12;
              final usableWidth = screenWidth - 24; // padding lateral da página
              final totalSpacing = (crossAxis - 1) * spacing;
              final cardWidth = (usableWidth - totalSpacing) / crossAxis;
              final cardHeight = cardWidth * 1.4; // proporção consistente

              // altura total: 2 linhas
              final gridHeight = (cardHeight * 2) + spacing + 24;

              return SizedBox(
                height: gridHeight,
                child: PageView.builder(
                  itemCount: pages.length,
                  controller: PageController(viewportFraction: 1.0),
                  itemBuilder: (_, pageIndex) {
                    final slice = pages[pageIndex];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxis,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: cardWidth / cardHeight,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10, // seu padrão de exibir 10 itens
                        itemBuilder: (_, idx) {
                          if (idx >= slice.length) {
                            return const SizedBox.shrink();
                          }

                          final p = slice[idx];
                          return ProductCard(
                            produto: p,
                            onAdd: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addProduct(p);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Adicionado ao carrinho')));
                            },
                            onSendRecipe: () {
                              if (!p.receitaObrigatoria) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Este produto não requer receita.')),
                                );
                                return;
                              }

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Receita Obrigatória'),
                                  content: const Text(
                                      'Este medicamento requer receita. Você pode enviar a imagem da receita pela tela do carrinho para este item.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('Fechar')),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),

      // floating cart button
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
                child: Text('${cart.items.length}',
                    style:
                        const TextStyle(fontSize: 11, color: Colors.white)),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavBar(
        currentIndex: navIndex,
        onTap: (index) {
          if (index == navIndex) return;

          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/products');
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/schedule');
          }
          if (index == 3) {
            Navigator.pushReplacementNamed(context, '/admin');
          }
        },
      ),
    );
  }
}
