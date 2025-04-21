// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Maquina copyWith({
    String? id,
    String? descricao,
    String? nivel,
    double? valor,
    int? disponibilidadeDeUso,
    String? codigo,
  }) {
    return Maquina(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      nivel: nivel ?? this.nivel,
      valor: valor ?? this.valor,
      disponibilidadeDeUso: disponibilidadeDeUso ?? this.disponibilidadeDeUso,
      codigo: codigo ?? this.codigo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'nivel': nivel,
      'valor': valor,
      'disponibilidadeDeUso': disponibilidadeDeUso,
      'codigo': codigo,
    };
  }

  factory Maquina.fromMap(Map<String, dynamic> map) {
    return Maquina(
      id: map['id'] as String,
      descricao: map['descricao'] as String,
      nivel: map['nivel'] as String,
      valor: map['valor'] as double,
      disponibilidadeDeUso: map['disponibilidadeDeUso'] as int,
      codigo: map['codigo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Maquina.fromJson(String source) => Maquina.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Maquina(id: $id, descricao: $descricao, nivel: $nivel, valor: $valor, disponibilidadeDeUso: $disponibilidadeDeUso, codigo: $codigo)';
  }

  @override
  bool operator ==(covariant Maquina other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.descricao == descricao &&
        other.nivel == nivel &&
        other.valor == valor &&
        other.disponibilidadeDeUso == disponibilidadeDeUso &&
        other.codigo == codigo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        nivel.hashCode ^
        valor.hashCode ^
        disponibilidadeDeUso.hashCode ^
        codigo.hashCode;
  }
}
