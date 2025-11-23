import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../models/produto.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final items = cart.items;

    // monta lista detalhada (Produto + quantidade)
    final detailed = items.entries.map((e) {
      final prod = productsProvider.items.firstWhere((p) => p.id == e.key, orElse: () => Produto(id: e.key, nome: 'Produto', preco: 0.0));
      return {
        'produto': prod,
        'qtd': e.value,
      };
    }).toList();

    double total = 0;
    for (var d in detailed) {
      final Produto p = d['produto'] as Produto;
      final int q = d['qtd'] as int;
      total += p.preco * q;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: detailed.isEmpty
          ? const Center(child: Text('Carrinho vazio'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: detailed.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final d = detailed[i];
                      final Produto p = d['produto'] as Produto;
                      final int qtd = d['qtd'] as int;

                      return ListTile(
                        leading: const Icon(Icons.medication, color: Color(0xFF0B8E7C)),
                        title: Text(p.nome),
                        subtitle: Text('R\$ ${p.preco.toStringAsFixed(2)} x $qtd'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.decreaseQuantity(p.id),
                            ),
                            Text('$qtd'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.addProduct(p),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                              onPressed: () => cart.removeProduct(p.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(child: Text('Total: R\$ ${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      ElevatedButton(
                        onPressed: () {
                          // finalizar compra simples: limpa carrinho e mostra confirmação
                          cart.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compra finalizada')));
                          Navigator.pop(context);
                        },
                        child: const Text('Finalizar compra'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
