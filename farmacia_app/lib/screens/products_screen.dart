import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import '../providers/cart_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Medicamentos")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.items.length,
        itemBuilder: (_, i) {
          final p = products.items[i];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProductCard(
              produto: p,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductDetailScreen(produto: p)),
                );
              },
              onAdd: () {
                if (p.receitaObrigatoria) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(produto: p)),
                  );
                } else {
                  cart.addProduct(p);
                }
              },
              onRemove: () => cart.decreaseQuantity(p.id),
            ),
          );
        },
      ),
    );
  }
}
