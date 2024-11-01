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
          future: lerToken(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();

            }else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty){
              return HomeScreen();
            } else{
            return Login();
          }
      },
      )
    );
  }
}
