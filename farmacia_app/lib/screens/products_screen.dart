import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_navbar.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int navIndex = 1;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Medicamentos")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (_, i) {
          final p = products[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ProductCard(
              produto: p,
              onTap: () {
                // se quiser abrir detalhe, abriu (mantive detalhe como opção)
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(produto: p)));
              },
              onAdd: () {
                if (p.receitaObrigatoria) {
                  // permite adicionar, mas aviso que precisa de receita para finalizar
                  cart.addProduct(p);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho — receita necessária para finalizar.')));
                } else {
                  cart.addProduct(p);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
                }
              },
              onSendRecipe: () {
                // instrução simples: enviar via carrinho
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Receita'),
                    content: const Text('Para enviar a receita, abra o carrinho e use "Enviar receita" no item.'),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ok'))],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navIndex,
        onTap: (i) {
          if (i == navIndex) return;
          if (i == 0) Navigator.pushReplacementNamed(context, '/home');
          if (i == 2) Navigator.pushReplacementNamed(context, '/schedule');
          if (i == 3) Navigator.pushReplacementNamed(context, '/admin');
        },
      ),
    );
  }
}
