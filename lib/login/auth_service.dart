import 'dart:convert';
import 'package:gerencia_manutencao/usuarios/usuario.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  Future<bool> login(String usuario, String senha) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/auth/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"usuario": usuario, "senha": senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      UserData.cargo = Usuario.fromMap(data['usuario']).cargo;
      UserData.nome = Usuario.fromMap(data['usuario']).nome;
      UserData.id = Usuario.fromMap(data['usuario']).id;
      return true;
    } else {
      return false;
    }
  }
}
