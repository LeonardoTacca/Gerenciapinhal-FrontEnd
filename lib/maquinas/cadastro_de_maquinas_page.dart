// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CadastroMaquinasPage extends StatefulWidget {
  const CadastroMaquinasPage({super.key});

  @override
  State<CadastroMaquinasPage> createState() => _CadastroMaquinasPageState();
}

class _CadastroMaquinasPageState extends State<CadastroMaquinasPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController nivelController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController disponibilidadeController = TextEditingController();

  final _currencyFormatter = FilteringTextInputFormatter.digitsOnly;

  String _formatCurrency(String value) {
    if (value.isEmpty) return '';
    final number = double.parse(value) / 100;
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Máquinas')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Código', codigoController),
              const SizedBox(height: 16),
              _buildTextField('Descrição', descricaoController),
              const SizedBox(height: 16),
              _buildTextField('Nível', nivelController),
              const SizedBox(height: 16),
              _buildTextField('Disponibilidade de Uso', disponibilidadeController,
                  keyboardType: TextInputType.number, isNumeric: true),
              const SizedBox(height: 16),
              _buildTextField('Valor', valorController, keyboardType: TextInputType.number, isCurrency: true),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Processar cadastro da máquina
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar Máquina',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, bool isNumeric = false, bool isCurrency = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: isCurrency
              ? [
                  _currencyFormatter,
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
                    return newValue.copyWith(
                      text: _formatCurrency(text),
                      selection: TextSelection.collapsed(offset: _formatCurrency(text).length),
                    );
                  })
                ]
              : isNumeric
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: label,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }
}
