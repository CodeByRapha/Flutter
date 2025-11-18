import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogged = false;
  final List<Map<String, String>> _users = [];

  Future<bool> login(String nome, String senha) async {
    final found = _users.any((u) => u['nome'] == nome && u['senha'] == senha);
    if (found) {
      isLogged = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String nome, String senha) async {
    if (_users.any((u) => u['nome'] == nome)) return false;

    _users.add({'nome': nome, 'senha': senha});
    isLogged = true;
    notifyListeners();
    return true;
  }

  void logout() {
    isLogged = false;
    notifyListeners();
  }
}
