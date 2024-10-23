import 'package:agenda/data/data_login.dart';
import 'package:agenda/entity/user.dart';
import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool isButtonDisabled = false;

  get dataLogin => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Usuário"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  final LoginDao dataLogin = LoginDao(); // Inicializa aqui
                  User newUser = User(usuario: loginController.text, senha: senhaController.text);
                  await dataLogin.save(newUser);
                  // Continue com o restante do código...
                },
                child: Text("Cadastrar"),
              )

              ],
        ),
      ),
    );
  }
}
