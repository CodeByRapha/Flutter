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
      Produto(id: '6', nome: 'Cetirizina 10mg', preco: 9.90),
      Produto(id: '7', nome: 'Paracetamol 500mg', preco: 8.50),
      Produto(id: '8', nome: 'Aspirina 100mg', preco: 7.30),
      Produto(id: '9', nome: 'Loratadina 10mg', preco: 11.20),
      Produto(id: '10', nome: 'Vitamina C 1000mg', preco: 19.00),
      Produto(id: '11', nome: 'Venlafaxina 75mg', preco: 58.90, receitaObrigatoria: true),
      Produto(id: '12', nome: 'Quetiapina 25mg', preco: 46.50, receitaObrigatoria: true),
      Produto(id: '13', nome: 'Vitamina B1 + B6', preco: 22.30),
      Produto(id: '14', nome: 'Sertralina 50mg', preco: 39.90, receitaObrigatoria: true),
      Produto(id: '15', nome: 'Vitamina C 500mg', preco: 18.70),

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
