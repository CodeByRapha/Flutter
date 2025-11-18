import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../models/produto.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Produto produto;
  const ProductDetailScreen({super.key, required this.produto});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? receitaPath;
  bool loading = false;

  Future<void> pickReceita() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        receitaPath = result.files.first.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.produto;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(p.nome)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Image.network(p.imagem, width: 150, height: 150, errorBuilder: (_, __, ___) => const Icon(Icons.medication, size: 96))),
          const SizedBox(height: 12),
          Text(p.nome, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(p.descricao),
          const SizedBox(height: 8),
          Text('R\$ ${p.preco.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          if (p.receitaObrigatoria)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Receita obrigatória', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ElevatedButton.icon(onPressed: pickReceita, icon: const Icon(Icons.upload), label: const Text('Anexar receita (imagem)')),
              if (receitaPath != null) Padding(padding: const EdgeInsets.only(top:8.0), child: Text('Arquivo: ${receitaPath!.split('/').last}'))
            ]),
          const Spacer(),
          ElevatedButton(
            onPressed: loading ? null : () {
              if (p.receitaObrigatoria && receitaPath == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Você precisa anexar a receita para esse medicamento')));
                return;
              }
              cart.addProduct(p, receitaPath: receitaPath);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adicionado ao carrinho')));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            child: const Text('Adicionar ao carrinho'),
          )
        ]),
      ),
    );
  }
}
