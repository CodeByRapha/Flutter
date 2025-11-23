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
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(produto: p))),
              onAdd: () {
                cart.addProduct(p);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
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
