import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/home/home_page.dart';
import 'package:http/http.dart' as http;
import '../models/peca.dart';

class PecaService extends ChangeNotifier {
  bool _isLoading = false;
  List<Peca> _pecas = [];

  bool get isLoading => _isLoading;
  List<Peca> get pecas => _pecas;

  Future<void> buscarTodasPecas() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3000/peca/buscar-todas-pecas');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _pecas = data.map((item) => Peca.fromMap(item)).toList();
      } else {
        _pecas = [];
      }
    } catch (e) {
      _pecas = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> criarPeca(BuildContext context, Peca peca) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3000/peca/criar');

    try {
      print(peca);
      final response = await http.post(url, body: jsonEncode(peca.toMap()));
      if (response.statusCode == 200) {
        _pecas.add(Peca.fromJson(response.body));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        _pecas = [];
      }
    } catch (e) {
      _pecas = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
