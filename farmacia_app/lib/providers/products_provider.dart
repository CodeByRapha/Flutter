import 'package:flutter/material.dart';
import '../models/produto.dart';

class ProductsProvider extends ChangeNotifier {
  final List<Produto> _items = [];

  List<Produto> get items => [..._items];

  void loadSampleProducts() {
    _items.addAll([
      Produto(id: "1", nome: "Dipirona", preco: 8.50),
      Produto(id: "2", nome: "Paracetamol", preco: 12),
      Produto(id: "3", nome: "Amoxicilina", preco: 27, receitaObrigatoria: true),
      Produto(id: "4", nome: "Ibuprofeno", preco: 19.90),
    ]);
    notifyListeners();
  }

  void addProduct(Produto p) {
    _items.add(p);
    notifyListeners();
  }
}
