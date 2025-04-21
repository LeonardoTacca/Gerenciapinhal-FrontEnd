import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/item_ordem.dart';

class ItensOrdemService extends ChangeNotifier {
  List<ItemOrdem> itemsOrdem = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> buscarItemsOrdem(String idOrdem) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/ItemsOrdem/buscarbuscar-itens-por-ordem'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idOrdem': idOrdem}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        itemsOrdem = data.map((e) => ItemOrdem.fromMap(e)).toList();
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        itemsOrdem = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      itemsOrdem = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> adicionarItemsOrdem(ItemOrdem item) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/ItemsOrdem/adicionar-item'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(item.toMap()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        itemsOrdem.add(ItemOrdem.fromMap(jsonDecode(response.body)));
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        itemsOrdem = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      itemsOrdem = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> excluirItemsOrdem(ItemOrdem item) async {
    setLoading(true);
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/ItemsOrdem/excluir-item'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idItem': item.id}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        itemsOrdem.remove(item);
        notifyListeners();
      } else {
        debugPrint('Erro ao criar ordem: ${response.statusCode}');
        itemsOrdem = [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro na requisição: $e');
      itemsOrdem = [];
      notifyListeners();
    } finally {
      setLoading(false);
    }
  }
}
