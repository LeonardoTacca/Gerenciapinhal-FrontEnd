// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Peca copyWith({
    String? id,
    String? codigo,
    String? descricao,
    UNID? unidade,
    int? nivel,
    double? valor,
  }) {
    return Peca(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      unidade: unidade ?? this.unidade,
      nivel: nivel ?? this.nivel,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'codigo': codigo,
      'descricao': descricao,
      'unidade': unidade.name,
      'nivel': nivel,
      'valor': valor,
    };
  }

  factory Peca.fromMap(Map<String, dynamic> map) {
    return Peca(
      id: map['id'] != null ? map['id'] as String : null,
      codigo: map['codigo'] as String,
      descricao: map['descricao'] as String,
      unidade: unidadeFromString(map['unidade']),
      nivel: map['nivel'] as int,
      valor: map['valor'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Peca.fromJson(String source) => Peca.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Peca(id: $id, codigo: $codigo, descricao: $descricao, unidade: $unidade, nivel: $nivel, valor: $valor)';
  }

  @override
  bool operator ==(covariant Peca other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.unidade == unidade &&
        other.nivel == nivel &&
        other.valor == valor;
  }

  @override
  int get hashCode {
    return id.hashCode ^ codigo.hashCode ^ descricao.hashCode ^ unidade.hashCode ^ nivel.hashCode ^ valor.hashCode;
  }
}

UNID unidadeFromString(String value) {
  switch (value) {
    case 'unidade':
      return UNID.unidade;
    case 'metro':
      return UNID.metro;
    case 'litro':
      return UNID.litro;

    default:
      return UNID.kilo;
  }
}
