// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'item_ordem.dart';

class OrdemManutencao {
  final String maquinaId;
  final String genero;
  final String especie;
  final String? id;
  String status;
  final String tipoManutencao;
  final String tipoEstoque;
  String? manutentorId;
  String? manutentorSecundarioId;
  String? requisitanteId;
  final List<ItemOrdem> itens = [];

  OrdemManutencao(
      {required this.maquinaId,
      required this.genero,
      required this.especie,
      required this.status,
      required this.tipoManutencao,
      required this.tipoEstoque,
      this.manutentorId,
      this.id,
      this.manutentorSecundarioId,
      this.requisitanteId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maquinaId': maquinaId,
      'genero': genero,
      'especie': especie,
      'id': id,
      'status': status,
      'tipoManutencao': tipoManutencao,
      'tipoEstoque': tipoEstoque,
      'manutentorId': manutentorId,
      'manutentorSecundarioId': manutentorSecundarioId,
      'requisitanteId': requisitanteId,
    };
  }

  factory OrdemManutencao.fromMap(Map<String, dynamic> map) {
    return OrdemManutencao(
      maquinaId: map['maquinaId'] as String,
      genero: map['genero'] as String,
      id: map['id'] as String,
      especie: map['especie'] as String,
      status: map['status'] as String,
      tipoManutencao: map['tipoManutencao'] as String,
      tipoEstoque: map['tipoEstoque'] as String,
      manutentorId: map['manutentorId'] != null ? map['manutentorId'] as String : null,
      manutentorSecundarioId: map['manutentorSecundarioId'] != null ? map['manutentorSecundarioId'] as String : null,
      requisitanteId: map['requisitanteId'] != null ? map['requisitanteId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemManutencao.fromJson(String source) =>
      OrdemManutencao.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemManutencao(maquinaId: $maquinaId, genero: $genero, especie: $especie, status: $status, tipoManutencao: $tipoManutencao, tipoEstoque: $tipoEstoque, manutentorId: $manutentorId, manutentorSecundarioId: $manutentorSecundarioId, requisitanteId: $requisitanteId)';
  }

  @override
  bool operator ==(covariant OrdemManutencao other) {
    if (identical(this, other)) return true;

    return other.maquinaId == maquinaId &&
        other.genero == genero &&
        other.especie == especie &&
        other.status == status &&
        other.tipoManutencao == tipoManutencao &&
        other.tipoEstoque == tipoEstoque &&
        other.manutentorId == manutentorId &&
        other.manutentorSecundarioId == manutentorSecundarioId &&
        other.requisitanteId == requisitanteId;
  }

  @override
  int get hashCode {
    return maquinaId.hashCode ^
        genero.hashCode ^
        especie.hashCode ^
        status.hashCode ^
        tipoManutencao.hashCode ^
        tipoEstoque.hashCode ^
        manutentorId.hashCode ^
        manutentorSecundarioId.hashCode ^
        requisitanteId.hashCode;
  }
}
