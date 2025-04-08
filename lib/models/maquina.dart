class Maquina {
  final String id;
  final String descricao;
  final String nivel;
  final double valor;
  final int disponibilidadeDeUso;
  final String codigo;

  Maquina({
    required this.id,
    required this.descricao,
    required this.nivel,
    required this.valor,
    required this.disponibilidadeDeUso,
    required this.codigo,
  });
}

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

  OrdemManutencao({
    required this.maquinaId,
    required this.genero,
    required this.especie,
    required this.status,
    required this.tipoManutencao,
    required this.tipoEstoque,
  });
}
