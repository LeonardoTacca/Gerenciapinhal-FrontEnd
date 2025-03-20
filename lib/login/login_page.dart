import 'package:flutter/material.dart';
import 'package:gerencia_manutencao/home/home_page.dart';
import 'package:gerencia_manutencao/login/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[100]),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.30,
            height: MediaQuery.of(context).size.height * 0.40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Faça o login com o usuario disponibilizado para continuar',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: const Text('Usuario'),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10))),
                    controller: usuarioController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                        label: const Text('Senha'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured; // Alterna visibilidade
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10))),
                    controller: senhaController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () async {
                        if (senhaController.text.isEmpty || usuarioController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Atenção",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text(
                                  "É necessario preencher o usuario e senha para realizar o login",
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Fecha o popup
                                    },
                                    child: const Text(
                                      "Voltar",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          bool result = await AuthService().login(usuarioController.text, senhaController.text);
                          if (result) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Atenção!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: const Text(
                                    "Senha Incorreta",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Fecha o popup
                                      },
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[400]),
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
