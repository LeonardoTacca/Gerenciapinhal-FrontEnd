import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  Future<bool> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('localhost:3000/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return true;
    } else {
      return false;
    }
  }
}
