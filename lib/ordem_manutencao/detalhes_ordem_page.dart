import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/ordem_manutencao.dart';

import '../models/item_ordem.dart';
import '../models/maquina.dart';
import '../models/peca';

class DetalhesOrdemPage extends StatefulWidget {
  final OrdemManutencao ordem;
  final Maquina maquina;
  final List<Peca> pecas;

  const DetalhesOrdemPage({super.key, required this.ordem, required this.maquina, required this.pecas});

  @override
  State<DetalhesOrdemPage> createState() => _DetalhesOrdemPageState();
}

class _DetalhesOrdemPageState extends State<DetalhesOrdemPage> {
  String? pecaSelecionada;
  int quantidade = 1;

  void _adicionarItem() {
    if (pecaSelecionada != null && quantidade > 0) {
      setState(() {
        widget.ordem.itens.add(ItemOrdem(idPeca: pecaSelecionada!, quantidade: quantidade));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Ordem')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Máquina: ${widget.maquina.descricao}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Gênero: ${widget.ordem.genero}'),
            Text('Espécie: ${widget.ordem.especie}'),
            Text('Status: ${widget.ordem.status}'),
            Text('Tipo de Manutenção: ${widget.ordem.tipoManutencao}'),
            Text('Tipo de Estoque: ${widget.ordem.tipoEstoque}'),
            const SizedBox(height: 16),
            const Text('Peças Utilizadas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...widget.ordem.itens.map((item) {
              final peca = widget.pecas.firstWhere((p) => p.id == item.idPeca);
              return Text('${peca.descricao} (Qtd: ${item.quantidade})');
            }),
            const Divider(height: 32),
            const Text('Adicionar Peça à Ordem', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: pecaSelecionada,
              items: widget.pecas.map((p) => DropdownMenuItem(value: p.id, child: Text(p.descricao))).toList(),
              onChanged: (value) => setState(() => pecaSelecionada = value),
              decoration: const InputDecoration(labelText: 'Peça'),
            ),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantidade'),
              onChanged: (value) => quantidade = int.tryParse(value) ?? 1,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _adicionarItem,
              child: const Text('Adicionar Peça'),
            ),
          ],
        ),
      ),
    );
  }
}
