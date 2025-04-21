import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/models/maquina.dart';

import '../maquinas/maquinas_service.dart';
import '../models/ordem_manutencao.dart';
import '../models/peca.dart';
import '../pecas/peca_service.dart';
import 'Criar_Ordem_Manutencao_page.dart';
import 'detalhes_ordem_page.dart';

class ListaOrdensManutencaoPageWrapper extends StatefulWidget {
  const ListaOrdensManutencaoPageWrapper({super.key});

  @override
  State<ListaOrdensManutencaoPageWrapper> createState() => _ListaOrdensManutencaoPageWrapperState();
}

class _ListaOrdensManutencaoPageWrapperState extends State<ListaOrdensManutencaoPageWrapper> {
  final PecaService _pecaService = PecaService();
  final MaquinaService _maquinaService = MaquinaService();
  final List<OrdemManutencao> ordens = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPecas();
  }

  Future<void> _loadPecas() async {
    await _pecaService.buscarTodasPecas(); // Carrega as peças
    if (mounted) {
      setState(() {
        _isLoading = false; // Após carregar as peças, atualiza o estado
      });
    }
  }

  Future<void> _loadMaquina(OrdemManutencao ordem) async {
    await _maquinaService.buscarMaquinaPorId(ordem.maquinaId);
  }

  void _navegarParaCriarOrdem() async {
    final novaOrdem = await Navigator.push<OrdemManutencao>(
      context,
      MaterialPageRoute(
        builder: (context) => const CriarOrdemManutencaoPage(),
      ),
    );
    if (novaOrdem != null) {
      setState(() => ordens.add(novaOrdem));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ordens de Manutenção')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ordens.length,
              itemBuilder: (context, index) {
                final ordem = ordens[index];

                return ListTile(
                  title: Text('Ordem Manutencao Nº ${ordem.id!}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${ordem.status}'),
                      Text('Tipo: ${ordem.tipoManutencao}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    child: const Text('Detalhes'),
                    onPressed: () async {
                      // Carregar a máquina antes de navegar para os detalhes
                      await _loadMaquina(ordem);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesOrdemPage(
                              ordem: ordem,
                              maquina: _maquinaService.maquina!,
                              pecas: _pecaService.pecas,
                            ),
                          ));
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: _navegarParaCriarOrdem,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
