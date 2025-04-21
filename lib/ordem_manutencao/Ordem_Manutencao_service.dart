import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/ordem_manutencao.dart';
import 'package:http/http.dart' as http;

class OrdemManutencaoService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> criarOrdem(OrdemManutencao ordem) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/OrdemsManutencao/criar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(ordem.toMap()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
}
