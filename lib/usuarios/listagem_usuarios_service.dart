import 'package:flutter/material.dart';
import 'usuario.dart';

class UsuarioService extends ChangeNotifier {
  final List<Usuario> _usuarios = [
    Usuario(
      id: '25621651561651sadas',
      nome: 'Alice',
      email: 'alice@email.com',
      cargo: Cargos.administradorGeral,
      usuario: '',
    ),
  ];

  List<Usuario> get usuarios => List.unmodifiable(_usuarios);

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
