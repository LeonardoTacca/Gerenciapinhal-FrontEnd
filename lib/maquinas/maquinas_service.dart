import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/maquina.dart';

class MaquinaService extends ChangeNotifier {
  bool _isLoading = false;
  List<Maquina> maquinas = [];
  bool get isLoading => _isLoading;
  Maquina? maquina;
  Future<bool> cadastrarMaquina({
    required String codigo,
    required String descricao,
    required String nivel,
    required double valor,
    required int disponibilidadeDeUso,
  }) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3000/maquina/criar');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'codigo': codigo,
        'descricao': descricao,
        'nivel': nivel,
        'valor': valor,
        'disponibilidade_de_uso': disponibilidadeDeUso,
      }),
    );

    _isLoading = false;
    notifyListeners();

    return response.statusCode == 200;
  }

  Future<void> buscarTodasMaquinas() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3000/maquina/buscar-todas');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        maquinas = data.map((item) => Maquina.fromMap(item)).toList();
      } else {
        maquinas = [];
      }
    } catch (e) {
      maquinas = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Maquina?> buscarMaquinaPorId(String id) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3000/maquina/buscar-maquina');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        maquina = Maquina.fromMap(data);
        notifyListeners();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
