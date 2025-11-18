import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.produto,
    this.onAdd,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Row(
          children: [
            const Icon(Icons.medication, size: 40, color: Color(0xFF0B8E7C)),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(produto.nome, style: const TextStyle(fontSize: 18)),
                  Text("R\$ ${produto.preco.toStringAsFixed(2)}"),
                  if (produto.receitaObrigatoria)
                    const Text("Requer receita",
                        style: TextStyle(color: Colors.red)),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onRemove,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
