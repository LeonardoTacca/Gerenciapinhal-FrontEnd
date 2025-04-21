import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/home/home_page.dart';
import 'package:gerencia_manutencao/usuarios/cadastro_usuarios_service.dart';
import 'package:gerencia_manutencao/usuarios/usuario.dart';

class CadastroUsuariosPage extends StatefulWidget {
  final Usuario? usuario;
  const CadastroUsuariosPage({super.key, this.usuario});

  @override
  State<CadastroUsuariosPage> createState() => _CadastroUsuariosPageState();
}

class _CadastroUsuariosPageState extends State<CadastroUsuariosPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmacaoSenhaController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  CadastroUsuariosService cadastroUsuariosService = CadastroUsuariosService();
  final List<String> _opcoes = ['AdministradorGeral', 'AdministradorManutencao', 'OperadorManutencao', 'Operador'];
  String? _opcaoSelecionada;
  bool obscuredSenha = true;
  bool obscuredSenhaConfirmacao = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: ListenableBuilder(
              listenable: cadastroUsuariosService,
              builder: (context, _) {
                if (cadastroUsuariosService.errorMessage == null &&
                    !cadastroUsuariosService.isLoading &&
                    cadastroUsuariosService.email != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }
                  });
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
                              children: [
                                _buildTextField('Nome completo', nomeController),
                                _buildTextField('Email', emailController, keyboardType: TextInputType.emailAddress),
                                _buildTextField('Nome de usuário', usuarioController),
                                _buildTextField('Senha', senhaController, obscureText: true),
                                _buildTextField('Confirme sua senha', confirmacaoSenhaController, obscureText: true),
                                _buildDropdownField(),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: cadastroUsuariosService.isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  cadastroUsuariosService.nome = nomeController.text;
                                  cadastroUsuariosService.email = emailController.text;
                                  cadastroUsuariosService.usuario = usuarioController.text;
                                  cadastroUsuariosService.senha = senhaController.text;
                                  cadastroUsuariosService.confirmacaoSenha = confirmacaoSenhaController.text;
                                  cadastroUsuariosService.cargo = _opcaoSelecionada;
                                  cadastroUsuariosService.enviarCadastroDeUsuarios();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: label,
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cargo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Cargo',
          ),
          value: _opcaoSelecionada,
          items: _opcoes.map((String opcao) {
            return DropdownMenuItem<String>(
              value: opcao,
              child: Text(opcao),
            );
          }).toList(),
          onChanged: (String? novaOpcao) {
            setState(() {
              _opcaoSelecionada = novaOpcao;
            });
          },
          validator: (value) => value == null ? 'Selecione um cargo' : null,
        ),
      ],
    );
  }
}
