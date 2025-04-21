// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemOrdem {
  final String? id;
  final String idPeca;
  final int quantidade;
  final String idOrdemManutencao;

  const ItemOrdem({
    this.id,
    required this.idPeca,
    required this.quantidade,
    required this.idOrdemManutencao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_peca': idPeca,
      'quantidade': quantidade,
      'id_ordem_manutencao': idOrdemManutencao,
    };
  }

  factory ItemOrdem.fromMap(Map<String, dynamic> map) {
    return ItemOrdem(
      id: map['id'] != null ? map['id'] as String : null,
      idPeca: map['id_peca'] as String,
      quantidade: map['quantidade'] as int,
      idOrdemManutencao: map['id_ordem_manutencao'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrdem.fromJson(String source) => ItemOrdem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemOrdem(id: $id, id_peca: $idPeca, quantidade: $quantidade, id_ordem_manutencao: $idOrdemManutencao)';
  }

  @override
  bool operator ==(covariant ItemOrdem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idPeca == idPeca &&
        other.quantidade == quantidade &&
        other.idOrdemManutencao == idOrdemManutencao;
  }

  @override
  int get hashCode {
    return id.hashCode ^ idPeca.hashCode ^ quantidade.hashCode ^ idOrdemManutencao.hashCode;
  }
}
