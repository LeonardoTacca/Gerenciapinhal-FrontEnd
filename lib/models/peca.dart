enum UNID { unidade, metro, litro, kilo } // Exemplo de enum, ajuste conforme seu uso real

class Peca {
  final String? id;
  final String codigo;
  final String descricao;
  final UNID unidade;
  final int nivel;
  final double valor;

  Peca({
    this.id,
    required this.codigo,
    required this.descricao,
    required this.unidade,
    required this.nivel,
    required this.valor,
  });
}
