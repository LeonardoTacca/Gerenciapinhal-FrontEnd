// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usuario {
  final String id;
  final String nome;
  final String email;
  final String usuario;
  final bool? precisaRedefinir;
  final Cargos cargo;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.usuario,
    this.precisaRedefinir,
    required this.cargo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'email': email,
      'usuario': usuario,
      'precisaRedefinir': precisaRedefinir,
      'cargo': cargo.name,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as String,
      nome: map['nome'] as String,
      email: map['email'] as String,
      usuario: map['usuario'] as String,
      precisaRedefinir: map['precisaRedefinir'] != null ? map['precisaRedefinir'] as bool : false,
      cargo: cargoFromString(map['cargo'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, email: $email, usuario: $usuario, precisaRedefinir: $precisaRedefinir, cargo: $cargo,';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.email == email &&
        other.usuario == usuario &&
        other.precisaRedefinir == precisaRedefinir &&
        other.cargo == cargo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ email.hashCode ^ usuario.hashCode ^ precisaRedefinir.hashCode ^ cargo.hashCode;
  }
}

enum Cargos {
  administradorGeral,
  administradorManutencao,
  operadorManutencao,
  operador,
}

Cargos cargoFromString(String value) {
  switch (value) {
    case 'AdministradorManutencao':
      return Cargos.administradorManutencao;
    case 'OperadorManutencao':
      return Cargos.operadorManutencao;
    case 'AdministradorGeral':
      return Cargos.administradorGeral;
    default:
      return Cargos.operador;
  }
}
