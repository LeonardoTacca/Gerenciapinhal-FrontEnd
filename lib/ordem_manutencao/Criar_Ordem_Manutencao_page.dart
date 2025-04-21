import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/maquinas/maquinas_service.dart';
import 'package:gerencia_manutencao/ordem_manutencao/Ordem_Manutencao_service.dart';

import '../models/ordem_manutencao.dart';

class CriarOrdemManutencaoPage extends StatefulWidget {
  const CriarOrdemManutencaoPage({super.key});

  @override
  State<CriarOrdemManutencaoPage> createState() => _CriarOrdemManutencaoPageState();
}

class _CriarOrdemManutencaoPageState extends State<CriarOrdemManutencaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _ordemService = OrdemManutencaoService();
  final _maquinaService = MaquinaService();

  String? maquinaId;
  String? genero;
  String? especie;
  String? tipoManutencao;
  String? tipoEstoque;

  @override
  void initState() {
    super.initState();
    _loadMaquinas();
  }

  Future<void> _loadMaquinas() async {
    await _maquinaService.buscarTodasMaquinas();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _criarOrdem() async {
    if (_formKey.currentState!.validate()) {
      final novaOrdem = OrdemManutencao(
          maquinaId: maquinaId!,
          manutentorId: '1',
          manutentorSecundarioId: '2',
          requisitanteId: '3',
          status: 'aguardando_inicio',
          tipoManutencao: tipoManutencao!,
          genero: genero!,
          tipoEstoque: tipoEstoque!,
          especie: especie!);

      final sucesso = await _ordemService.criarOrdem(novaOrdem);

      if (sucesso) {
        if (mounted) Navigator.pop(context, novaOrdem);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao criar a ordem de manutenção.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Ordem de Manutenção')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _maquinaService.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      DropdownButtonFormField<String>(
                        value: maquinaId,
                        items: _maquinaService.maquinas.map((m) {
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
                        items:
                            ['corretiva', 'preventiva'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
                      GestureDetector(
                        onTap: _ordemService.isLoading ? null : _criarOrdem,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _ordemService.isLoading ? Colors.grey : Colors.blue[400],
                          ),
                          child: Center(
                            child: _ordemService.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Criar Ordem',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
