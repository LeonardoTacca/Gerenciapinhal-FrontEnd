import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'usuario.dart';

class UsuarioService extends ChangeNotifier {
  final List<Usuario> _usuarios = [];
  List<Usuario> get usuarios => List.unmodifiable(_usuarios);

  Future<void> carregarUsuarios() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/usuario/listar'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _usuarios.clear();
        _usuarios.addAll(data.map((e) => Usuario.fromMap(e)));
        notifyListeners();
      } else {
        debugPrint('Erro ao carregar usuários: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
    }
  }

  void adicionar(Usuario usuario) {
    _usuarios.add(usuario);
    notifyListeners();
  }

  void editar(String id, Usuario novo) {
    final index = _usuarios.indexWhere((u) => u.id == id);
    if (index != -1) {
      _usuarios[index] = novo;
      notifyListeners();
    }
  }

  void remover(String id) {
    _usuarios.removeWhere((u) => u.id == id);
    notifyListeners();
  }
}
