import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final products = Provider.of<ProductsProvider>(context);

    final ids = cart.items.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Carrinho")),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ids.length,
        itemBuilder: (_, i) {
          final id = ids[i];
          final produto = products.items.firstWhere((p) => p.id == id);

          return ListTile(
            title: Text(produto.nome),
            subtitle: Text("Quantidade: ${cart.items[id]}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => cart.removeProduct(id),
            ),
          );
        },
      ),
    );
  }
}
