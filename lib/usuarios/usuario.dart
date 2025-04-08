class Usuario {
  final String id;
  final String nome;
  final String email;
  final String usuario;
  final bool? precisaRedefinir;
  final Cargos cargo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Usuario(
      {required this.id,
      required this.nome,
      required this.email,
      required this.usuario,
      this.precisaRedefinir,
      required this.cargo,
      this.createdAt,
      this.updatedAt});
}

enum Cargos {
  administradorGeral,
  administradorManutencao,
  operadorManutencao,
  operador,
}
