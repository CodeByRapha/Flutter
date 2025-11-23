import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/produto.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Produto produto;
  const ProductDetailScreen({super.key, required this.produto});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? receitaPath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() => receitaPath = img.path);

      // Atualiza provider
      Provider.of<ProductsProvider>(context, listen: false)
          .updatePrescription(widget.produto.id, img.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Receita carregada com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.produto.nome)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.medication, size: 90, color: Colors.teal),
            const SizedBox(height: 12),

            Text(
              widget.produto.nome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Preço: R\$ ${widget.produto.preco.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 12),

            if (widget.produto.receitaObrigatoria)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Requer receita médica",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload_file),
                    label: Text(receitaPath == null
                        ? "Enviar Receita"
                        : "Receita Enviada ✔"),
                  ),

                  const SizedBox(height: 8),
                ],
              ),

            // empurra o botão para o fim
            const Spacer(),

            // BOTÃO CENTRALIZADO
            Center(
              child: SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.produto.receitaObrigatoria &&
                        (receitaPath == null &&
                         widget.produto.receitaImagem == null)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Envie a receita para adicionar este item."),
                        ),
                      );
                      return;
                    }

                    cart.addProduct(widget.produto);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Adicionado ao carrinho")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: const Text("Adicionar ao carrinho"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
