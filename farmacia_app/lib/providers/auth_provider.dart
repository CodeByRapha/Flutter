import 'package:flutter/material.dart';
import '../models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  final List<Usuario> _usuarios = [];

  Usuario? _logado;

  Usuario? get usuario => _logado;
  bool get isLogged => _logado != null;

  // ---------- LOGIN DO ADMIN (fixo) ----------
  final String adminUser = "admin";
  final String adminPass = "1234";

  Future<bool> register(String nome, String senha) async {
    if (_usuarios.any((u) => u.nome == nome)) return false;
    _usuarios.add(Usuario(nome: nome, senha: senha));
    _logado = _usuarios.last;
    notifyListeners();
    return true;
  }

  bool login(String nome, String senha) {

    // ---------- VERIFICA ADMIN PRIMEIRO ----------
    if (nome == adminUser && senha == adminPass) {
      _logado = Usuario(nome: adminUser, senha: adminPass);
      notifyListeners();
      return true;
    }

    // ---------- LOGIN NORMAL ----------
    final user = _usuarios.firstWhere(
      (u) => u.nome == nome && u.senha == senha,
      orElse: () => Usuario(nome: '', senha: ''),
    );

    if (user.nome.isEmpty) return false;

    _logado = user;
    notifyListeners();
    return true;
  }

  void logout() {
    _logado = null;
    notifyListeners();
  }
}
