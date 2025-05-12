import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerencia_manutencao/models/peca.dart';
import 'package:intl/intl.dart';
import 'peca_service.dart';

class CadastroPecasPage extends StatefulWidget {
  const CadastroPecasPage({super.key});

  @override
  State<CadastroPecasPage> createState() => _CadastroPecasPageState();
}

class _CadastroPecasPageState extends State<CadastroPecasPage> {
  final formKey = GlobalKey<FormState>();
  final PecaService pecaService = PecaService();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController nivelController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final List<String> _unidades = ['UNID', 'CX', 'KG', 'M'];
  String? _unidadeSelecionada;

  final _currencyFormatter = FilteringTextInputFormatter.digitsOnly;

  String _formatCurrency(String value) {
    if (value.isEmpty) return '';
    final number = double.parse(value) / 100;
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(number);
  }

  double _parseCurrency(String formatted) {
    final cleaned = formatted.replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
    return double.tryParse(cleaned) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Peças')),
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
              _buildDropdownField(),
              const SizedBox(height: 16),
              _buildTextField('Nível', nivelController, keyboardType: TextInputType.number, isNumeric: true),
              const SizedBox(height: 16),
              _buildTextField('Valor', valorController, keyboardType: TextInputType.number, isCurrency: true),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await pecaService.criarPeca(
                        context,
                        Peca(
                          codigo: codigoController.text,
                          descricao: descricaoController.text,
                          unidade: unidadeFromString(_unidadeSelecionada!),
                          nivel: int.parse(nivelController.text),
                          valor: _parseCurrency(valorController.text),
                        ),
                      );
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
                    'Cadastrar Peça',
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
                    final formatted = _formatCurrency(text);
                    return TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
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

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Unidade', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Unidade',
          ),
          value: _unidadeSelecionada,
          items: _unidades.map((String unidade) {
            return DropdownMenuItem<String>(
              value: unidade,
              child: Text(unidade),
            );
          }).toList(),
          onChanged: (String? novaUnidade) {
            setState(() {
              _unidadeSelecionada = novaUnidade;
            });
          },
          validator: (value) => value == null ? 'Selecione uma unidade' : null,
        ),
      ],
    );
  }
}
