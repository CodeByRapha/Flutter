import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const ProductCard({
    super.key,
    required this.produto,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.medical_services, size: 40, color: Color(0xFF0B8E7C)),
            const SizedBox(height: 10),

            Text(
              produto.nome,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),

            Text(
              "R\$ ${produto.preco.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Color(0xFF0B8E7C),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (produto.receitaObrigatoria)
                  const Tooltip(
                    message: 'Receita obrigatória',
                    child: Icon(Icons.receipt_long, size: 18, color: Colors.redAccent),
                  ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline, size: 26, color: Color(0xFF0B8E7C)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
