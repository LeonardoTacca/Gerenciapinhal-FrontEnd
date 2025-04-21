// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemOrdem {
  final String idPeca;
  final int quantidade;

  ItemOrdem({
    required this.idPeca,
    required this.quantidade,
  });

  ItemOrdem copyWith({
    String? idPeca,
    int? quantidade,
  }) {
    return ItemOrdem(
      idPeca: idPeca ?? this.idPeca,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPeca': idPeca,
      'quantidade': quantidade,
    };
  }

  factory ItemOrdem.fromMap(Map<String, dynamic> map) {
    return ItemOrdem(
      idPeca: map['idPeca'] as String,
      quantidade: map['quantidade'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOrdem.fromJson(String source) => ItemOrdem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ItemOrdem(idPeca: $idPeca, quantidade: $quantidade)';

  @override
  bool operator ==(covariant ItemOrdem other) {
    if (identical(this, other)) return true;

    return other.idPeca == idPeca && other.quantidade == quantidade;
  }

  @override
  int get hashCode => idPeca.hashCode ^ quantidade.hashCode;
}
