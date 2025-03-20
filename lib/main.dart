import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/login/login_page.dart';

void main() {
  runApp(MaterialApp(
      title: 'ManutencaoCustom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage()));
}
