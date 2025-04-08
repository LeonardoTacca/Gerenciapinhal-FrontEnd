import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/usuarios/cadastro_usuarios_page.dart';
import 'package:gerencia_manutencao/usuarios/listagem_usuarios_service.dart';
import 'package:gerencia_manutencao/usuarios/usuario.dart';
import 'package:gerencia_manutencao/usuarios/widgets/componente_listagem_usuario.dart';

class ListaUsuariosPage extends StatefulWidget {
  const ListaUsuariosPage({super.key});

  @override
  State<ListaUsuariosPage> createState() => _ListaUsuariosPageState();
}

class _ListaUsuariosPageState extends State<ListaUsuariosPage> {
  final UsuarioService _usuarioService = UsuarioService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _usuarioService.addListener(_onUsuariosChanged);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _usuarioService.removeListener(_onUsuariosChanged);
    _usuarioService.dispose();
    super.dispose();
  }

  void _onUsuariosChanged() {
    setState(() {});
  }

  void _navegarParaCadastro({Usuario? usuario}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroUsuariosPage(usuario: usuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => _navegarParaCadastro(),
              icon: const Icon(Icons.add),
              label: const Text('Criar usuário'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _usuarioService.usuarios.isEmpty
                      ? const Center(child: Text('Nenhum usuário encontrado.'))
                      : ListView.builder(
                          itemCount: _usuarioService.usuarios.length,
                          itemBuilder: (context, index) {
                            final usuario = _usuarioService.usuarios[index];
                            return UsuarioTile(
                              usuario: usuario,
                              onEditar: () => _navegarParaCadastro(usuario: usuario),
                              onExcluir: () => _usuarioService.remover(usuario.id),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
