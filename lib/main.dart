import 'package:agenda/screen/cadastro.dart';
import 'package:agenda/screen/cadastro_usuario.dart';
import 'package:agenda/screen/home.dart';
import 'package:agenda/screen/login.dart';
import 'package:agenda/token/token.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
          future: carregarDados('token'),
          builder: (BuildContext context, snapshot) {
          String? StringNova = snapshot.data;
          print('Conteúdo do token ma MyApp: ${StringNova}');
          if (StringNova != null && StringNova.isNotEmpty) {
          return HomeScreen(); //tela Principal
          }else{
            return Login();
          }
      },
      ) // Define a HomeScreen como a tela inicial
    );
  }
}
