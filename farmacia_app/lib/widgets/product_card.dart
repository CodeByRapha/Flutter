import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProductCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback? onTap; // usado em telas que querem abrir detalhe
  final VoidCallback? onAdd;
  final VoidCallback? onSendRecipe;

  const ProductCard({
    super.key,
    required this.produto,
    this.onTap,
    this.onAdd,
    this.onSendRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // comportamento: se for com receita, avisa; se não for, usa onAdd (ou faz nada)
        if (produto.receitaObrigatoria) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Este produto requer receita. Use o ícone da receita para enviar.')),
          );
        } else {
          if (onAdd != null) onAdd!();
        }
        // se quem chamou deseja abrir detalhe, pode passar onTap e usar
        if (onTap != null) onTap!();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: MediaQuery.of(context).size.height * 0.2,
        width:  MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.medical_services, size: 36, color: Color(0xFF0B8E7C)),
            const SizedBox(height: 8),
            Text(produto.nome, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("R\$ ${produto.preco.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFF0B8E7C), fontWeight: FontWeight.bold)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                produto.receitaObrigatoria
                    ? IconButton(
                        onPressed: onSendRecipe,
                        icon: const Icon(Icons.receipt_long, color: Colors.redAccent),
                        tooltip: 'Enviar/Ver receita',
                      )
                    : const SizedBox.shrink(),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline, size: 28, color: Color(0xFF0B8E7C)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
