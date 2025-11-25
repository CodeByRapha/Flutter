import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../models/produto.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _pickAndAttachRecipe(BuildContext context, String productId) async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;
    Provider.of<ProductsProvider>(context, listen: false).updatePrescription(productId, img.path);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Receita anexada ao produto')));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final items = cart.items;

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
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('R\$ ${p.preco.toStringAsFixed(2)} x $qtd'),
                            if (p.receitaObrigatoria)
                              Text(p.receitaImagem == null ? 'Receita: não enviada' : 'Receita: enviada', style: TextStyle(color: p.receitaImagem == null ? Colors.red : Colors.green)),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => cart.decreaseQuantity(p.id)),
                            Text('$qtd'),
                            IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => cart.addProduct(p)),
                            IconButton(icon: const Icon(Icons.upload_file, color: Colors.blueAccent), onPressed: () => _pickAndAttachRecipe(context, p.id)),
                            IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent), onPressed: () => cart.removeProduct(p.id)),
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
                          // validação: se existir item com receitaObrigatoria e sem receitaImagem => bloquear
                          final missing = detailed.where((d) {
                            final Produto p = d['produto'] as Produto;
                            return p.receitaObrigatoria && p.receitaImagem == null;
                          }).toList();

                          if (missing.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Receita necessária'),
                                content: const Text('Alguns itens exigem receita. Envie a receita para cada item antes de finalizar a compra.'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendi')),
                                ],
                              ),
                            );
                            return;
                          }

                          // finalizar
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
