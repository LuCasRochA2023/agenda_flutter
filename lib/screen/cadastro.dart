
import 'package:agenda/data/data_dao.dart';
import 'package:agenda/entity/Contato.dart';
import 'package:agenda/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  final Repository ct;
  Cadastro({required this.ct});

  @override
  State<Cadastro> createState() => _CadastroState( );
}

class _CadastroState extends State<Cadastro> {
  final Repository rc = Repository();
    final DataDao dataDao = DataDao();
   String errorTel="";
   bool erroNome  = false;
   bool erroEmail = false;
   bool erroTelefone = false;
   String errorEmail = "";
   String errorNome = "";

   final TextEditingController nomeController = TextEditingController();
   final TextEditingController emailController = TextEditingController();
   final TextEditingController telefoneController = TextEditingController();

   void validador() {
     setState(() {
       erroNome = nomeController.text.isEmpty;
       errorNome = erroNome ? "Nome não pode estar em branco!" : '';

       erroTelefone = telefoneController.text.length != 16;
       errorTel = erroTelefone ? "Telefone Inválido deve ter 16 digitos!" : '';


       erroEmail = !(emailController.text.contains("@") && emailController.text.contains("."));
       errorEmail = erroEmail ? "E-mail Inválido!" : '';
     });
   }final MaskTextInputFormatter mascaraTel = new MaskTextInputFormatter( //Mascara para telefone
      mask: '(##) # ####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),centerTitle: true,
      ),
      body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/images/pinguim.jpg",
                fit: BoxFit.contain,
              ),
            ),
            Column(

            children: [
            TextField(
              decoration: InputDecoration(
            labelText: "Nome",
            errorText: erroNome ? errorNome : null,
          ),
          controller: nomeController,
          onChanged:  (value) {
            setState((){
               if (nomeController.text.isEmpty) {
               erroNome = true;
               errorNome = "Nome não pode ficar em branco !";
               } else {
               erroNome = false;
               errorNome = '';
            }});
            },),
          TextField(
            decoration: InputDecoration(
              labelText: "Telefone",
              errorText: erroTelefone ? errorTel : null,
            ),
            controller: telefoneController,
            inputFormatters:  <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              mascaraTel,],
            onChanged: (value) {
              setState(() {
                if(nomeController.text.isEmpty){
                  erroTelefone = true;
                  errorTel = "Telefone não pode ficar em branco!";

                }else{
                  errorTel = "";
                  erroTelefone = false;
                }
              });
            },
          ),TextField(

              decoration: InputDecoration(
                labelText: "E-mail",
                errorText: erroEmail ? errorEmail : null,

              ),
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  if(emailController.text.isEmpty){
                    errorEmail = "O campo e-mail não pode ficar vazio!";
                    erroEmail = false;
                  }
                });
              }
              )],
            ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            validador();
            if (!erroNome && !erroTelefone && !erroEmail) {
              widget.ct.addContato(
                dataDao,
                nomeController.text,
                telefoneController.text,
                emailController.text,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Cadastro realizado com sucesso!"),duration: Duration(seconds: 5),
                ),
              );
              Future.delayed(Duration(seconds: 2), ()
              {
                Navigator.pop(context, true);
              });
            }
          },
          child: Text("Cadastrar"),
        )],

     ),
     ))

    );  }
}
