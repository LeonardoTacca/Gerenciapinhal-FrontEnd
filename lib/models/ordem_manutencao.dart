import 'item_ordem.dart';

class OrdemManutencao {
  final String maquinaId;
  final String genero;
  final String especie;
  String status;
  final String tipoManutencao;
  final String tipoEstoque;
  String? manutentorId;
  String? manutentorSecundarioId;
  String? requisitanteId;
  final List<ItemOrdem> itens = [];

  OrdemManutencao({
    required this.maquinaId,
    required this.genero,
    required this.especie,
    required this.status,
    required this.tipoManutencao,
    required this.tipoEstoque,
  });
}
