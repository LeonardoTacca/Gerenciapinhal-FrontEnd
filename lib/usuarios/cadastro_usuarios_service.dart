import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CadastroUsuariosService extends ChangeNotifier {
  String? nome;
  String? email;
  String? senha;
  String? confirmacaoSenha;
  String? usuario;
  String? cargo;
  bool precisaRedefinir = true;

  // Estado
  bool isLoading = false;
  String? errorMessage;
  Future<void> enviarCadastroDeUsuarios() async {
    final String baseUrl = "http://localhost:3000";
    if (senha != confirmacaoSenha) {
      errorMessage = 'As senhas não coincidem';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuario/cadastro'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "usuario": {
            'nome': nome,
            'email': email,
            'senha': senha,
            'usuario': usuario,
            'precisa_redefinir': precisaRedefinir,
            'cargo': cargo
          }
        }),
      );

      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();
      } else {
        errorMessage = 'Erro no servidor: ${response.statusCode}';
        if (response.body.isNotEmpty) {
          final errorData = json.decode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Erro de conexão: ${e.toString()}';
      isLoading = false;
      notifyListeners();
    }
  }
}
