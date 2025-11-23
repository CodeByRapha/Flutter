import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Produto> _items = [];

  List<Produto> get items => List.unmodifiable(_items);

  void loadSampleProducts() {
    _items.clear();
    _items.addAll([
      Produto(id: '1', nome: 'Dipirona 500mg', preco: 12.90),
      Produto(id: '2', nome: 'Ibuprofeno 200mg', preco: 18.50),
      Produto(id: '3', nome: 'Amoxicilina 500mg', preco: 29.90, receitaObrigatoria: true),
      Produto(id: '4', nome: 'Omeprazol 20mg', preco: 15.00),
      Produto(id: '5', nome: 'Rivotril 2mg', preco: 33.00, receitaObrigatoria: true),
    ]);
    notifyListeners();
  }

  void addProduct(Produto p) {
    _items.add(p);
    notifyListeners();
  }

  void updatePrescription(String id, String imagePath) {
    final prod = _items.firstWhere((p) => p.id == id);
    prod.receitaImagem = imagePath;
    notifyListeners();
  }
}
