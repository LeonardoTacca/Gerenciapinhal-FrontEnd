import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/usuarios/usuario.dart';

class UsuarioTile extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const UsuarioTile({
    super.key,
    required this.usuario,
    required this.onEditar,
    required this.onExcluir,
  });

  String cargoToString(Cargos cargo) {
    switch (cargo) {
      case Cargos.administradorGeral:
        return 'Administrador Geral';
      case Cargos.administradorManutencao:
        return 'Administrador Manutenção';
      case Cargos.operadorManutencao:
        return 'Operador Manutenção';
      case Cargos.operador:
        return 'Operador';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(usuario.nome),
        subtitle: Text(cargoToString(usuario.cargo)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditar,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onExcluir,
            ),
          ],
        ),
      ),
    );
  }
}
