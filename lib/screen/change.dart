import 'package:agenda/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../entity/Contato.dart';

class Alterar extends StatefulWidget {
  final Repository rc;
  final Contato contato;
  final int index;

  Alterar({required this.rc, required this.contato, required this.index});

  @override
  State<Alterar> createState() => _AlteracaoCadastroState(rc: rc, contato: contato, indice: index);
}

class _AlteracaoCadastroState extends State<Alterar> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String telErro = "";
  String emailErro = "";
  bool erroTelefone = false;
  bool erroEmail = false;
  bool erroNome = false;
  String nomeErro = "";

  final Repository rc;
  final int indice;

  _AlteracaoCadastroState({required this.rc, required Contato contato, required this.indice}) {
    nomeController.text = contato.nome;
    telefoneController.text = contato.telefone;
    emailController.text = contato.email;
  }

  final MaskTextInputFormatter mascaraTel = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  void _validarCampos() {
    setState(() {
      if (nomeController.text.isEmpty) {
        erroNome = true;
        nomeErro = "Nome não pode estar em branco!";
      } else {
        erroNome = false;
        nomeErro = '';
      }

      if (telefoneController.text.length != 16) {
        erroTelefone = true;
        telErro = "Telefone Inválido!";
      } else {
        erroTelefone = false;
        telErro = '';
      }

      if (!(emailController.text.contains("@") && emailController.text.contains("."))) {
        erroEmail = true;
        emailErro = "E-mail Inválido!";
      } else {
        erroEmail = false;
        emailErro = '';
      }
    });
  }

  void _confirmarRemocao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Remoção'),
          content: Text("Você tem certeza que deseja remover o contato " + nomeController.text + "?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () {
                setState(() {
                  rc.removerContato(widget.contato);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato ' + nomeController.text + ' removido com sucesso!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alteração de Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                errorText: erroNome ? nomeErro : null,
              ),
              controller: nomeController,
              onChanged: (value) {
                setState(() {
                  if (nomeController.text.isEmpty) {
                    erroNome = true;
                    nomeErro = "Nome não pode estar em branco!";
                  } else {
                    erroNome = false;
                    nomeErro = '';
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                errorText: erroTelefone ? telErro : null,
              ),
              controller: telefoneController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                mascaraTel,
              ],
              onChanged: (value) {
                setState(() {
                  if (telefoneController.text.length != 16) {
                    erroTelefone = true;
                    telErro = "Telefone Inválido!";
                  } else {
                    erroTelefone = false;
                    telErro = '';
                  }
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: erroEmail ? emailErro : null,
              ),
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  if (!(emailController.text.contains("@") && emailController.text.contains("."))) {
                    erroEmail = true;
                    emailErro = "E-mail Inválido!";
                  } else {
                    erroEmail = false;
                    emailErro = '';
                  }
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validarCampos();
                if (!erroNome && !erroTelefone && !erroEmail) {
                  rc.atualizarContato(
                    Contato(
                      nome: nomeController.text,
                      telefone: telefoneController.text,
                      email: emailController.text,
                    ),
                    indice,
                  );
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, verifique os campos digitados.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Salvar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _confirmarRemocao(context),
              child: Text('Remover Contato'),
            ),
          ],
        ),
      ),
    );
  }
}
