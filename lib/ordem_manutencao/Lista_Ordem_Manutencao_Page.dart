import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/maquina.dart';

import '../models/ordem_manutencao.dart';
import '../models/peca';
import 'Criar_Ordem_Manutencao_page.dart';
import 'detalhes_ordem_page.dart';

class ListaOrdensManutencaoPageWrapper extends StatefulWidget {
  const ListaOrdensManutencaoPageWrapper({super.key});

  @override
  State<ListaOrdensManutencaoPageWrapper> createState() => _ListaOrdensManutencaoPageWrapperState();
}

class _ListaOrdensManutencaoPageWrapperState extends State<ListaOrdensManutencaoPageWrapper> {
  final List<Maquina> maquinasDisponiveis = [
    Maquina(id: '1', descricao: 'Torno CNC', nivel: 'A', valor: 10000, disponibilidadeDeUso: 1, codigo: 'T001'),
    Maquina(id: '2', descricao: 'Fresadora XYZ', nivel: 'B', valor: 8500, disponibilidadeDeUso: 1, codigo: 'F002'),
  ];

  final List<Peca> pecasDisponiveis = [
    Peca(id: '1', codigo: 'P001', descricao: 'Parafuso', unidade: 'un', nivel: 1, valor: 1.5),
    Peca(id: '2', codigo: 'P002', descricao: 'Engrenagem', unidade: 'un', nivel: 2, valor: 10.0),
  ];

  final List<OrdemManutencao> ordens = [];

  void _navegarParaCriarOrdem() async {
    final novaOrdem = await Navigator.push<OrdemManutencao>(
      context,
      MaterialPageRoute(
        builder: (context) => CriarOrdemManutencaoPage(maquinas: maquinasDisponiveis),
      ),
    );
    if (novaOrdem != null) {
      setState(() => ordens.add(novaOrdem));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ordens de Manutenção')),
      body: ListView.builder(
        itemCount: ordens.length,
        itemBuilder: (context, index) {
          final ordem = ordens[index];
          final maquina = maquinasDisponiveis.firstWhere((m) => m.id == ordem.maquinaId);
          return ListTile(
            title: Text(maquina.descricao),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${ordem.status}'),
                Text('Tipo: ${ordem.tipoManutencao}'),
              ],
            ),
            trailing: ElevatedButton(
              child: const Text('Detalhes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesOrdemPage(ordem: ordem, maquina: maquina, pecas: pecasDisponiveis),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaCriarOrdem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
