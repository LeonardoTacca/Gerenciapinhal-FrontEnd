import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/ordem_manutencao.dart';
import 'package:http/http.dart' as http;

class OrdemManutencaoService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<OrdemManutencao> ordens = [];
  OrdemManutencao? ordemManutencaoFiltrada;
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

  Future<void> buscarTodasOrdens() async {
    setLoading(true);
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/OrdemsManutencao/buscar-todas'),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        ordens = data.map((e) => OrdemManutencao.fromMap(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        ordens = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      ordens = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> buscarOrdensFiltradasParaManutencao(String idManutentor) async {
    setLoading(true);
    try {
      final response = await http.post(Uri.parse('http://localhost:3000/OrdemsManutencao/buscar-todas-por-manutentor'),
          headers: {'Content-Type': 'application/json'}, body: jsonEncode({'idUsuario': idManutentor}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        ordens = data.map((e) => OrdemManutencao.fromMap(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        ordens = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      ordens = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> buscarOrdensFiltradasPorOperador(String idOperador) async {
    setLoading(true);
    try {
      final response = await http.post(
          Uri.parse('http://localhost:3000/OrdemsManutencao/buscar-todas-por-requisitante'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idUsuario': idOperador}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        ordens = data.map((e) => OrdemManutencao.fromMap(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        ordens = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      ordens = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }
}
