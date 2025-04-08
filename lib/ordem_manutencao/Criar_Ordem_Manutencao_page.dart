import 'package:flutter/material.dart';

import '../models/maquina.dart';
import '../models/ordem_manutencao.dart';

class CriarOrdemManutencaoPage extends StatefulWidget {
  final List<Maquina> maquinas;

  const CriarOrdemManutencaoPage({super.key, required this.maquinas});

  @override
  State<CriarOrdemManutencaoPage> createState() => _CriarOrdemManutencaoPageState();
}

class _CriarOrdemManutencaoPageState extends State<CriarOrdemManutencaoPage> {
  final _formKey = GlobalKey<FormState>();
  String? maquinaId;
  String? genero;
  String? especie;
  String? tipoManutencao;
  String? tipoEstoque;

  void _criarOrdem() {
    if (_formKey.currentState!.validate()) {
      final novaOrdem = OrdemManutencao(
        maquinaId: maquinaId!,
        genero: genero!,
        especie: especie!,
        status: 'aguardando_inicio',
        tipoManutencao: tipoManutencao!,
        tipoEstoque: tipoEstoque!,
      );
      Navigator.pop(context, novaOrdem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Ordem de Manutenção')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: maquinaId,
                items: widget.maquinas.map((m) {
                  return DropdownMenuItem(value: m.id, child: Text(m.descricao));
                }).toList(),
                onChanged: (value) => setState(() => maquinaId = value),
                decoration: const InputDecoration(labelText: 'Máquina'),
                validator: (value) => value == null ? 'Selecione uma máquina' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: genero,
                items: ['hidraulica', 'mecanica', 'eletrica']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => genero = value),
                decoration: const InputDecoration(labelText: 'Gênero da Manutenção'),
              ),
              DropdownButtonFormField<String>(
                value: especie,
                items: ['corretiva', 'preventiva'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => especie = value),
                decoration: const InputDecoration(labelText: 'Espécie da Manutenção'),
              ),
              DropdownButtonFormField<String>(
                value: tipoManutencao,
                items: ['interno', 'externo'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => tipoManutencao = value),
                decoration: const InputDecoration(labelText: 'Tipo de Manutenção'),
              ),
              DropdownButtonFormField<String>(
                value: tipoEstoque,
                items: ['cidade', 'estoque'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => tipoEstoque = value),
                decoration: const InputDecoration(labelText: 'Tipo de Estoque'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _criarOrdem,
                child: const Text('Criar Ordem'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
