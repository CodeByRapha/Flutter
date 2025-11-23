import 'package:flutter/material.dart';
import '../models/produto.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, int> _items = {};

  Map<String, int> get items => _items;

  void addProduct(Produto p) {
    _items.update(p.id, (q) => q + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id] == 1) {
      _items.remove(id);
    } else {
      _items[id] = _items[id]! - 1;
    }
    notifyListeners();
  }

  void removeProduct(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
