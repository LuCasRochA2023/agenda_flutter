import 'package:agenda/repository/repository.dart';
import 'package:agenda/screen/cadastro.dart';
import 'package:agenda/screen/list.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
   HomeScreen ({super.key});
  final Repository  rc = Repository();

  @override
  Widget  build(BuildContext context) {
     return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(


          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  Scaffold(
          appBar:AppBar(title: Text("Agenda", ), centerTitle: true ,

            backgroundColor: Colors.lightBlue,),
          body: Container(

              child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[

                    Image.asset("assets/images/livro.jpg"),

                    Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Column( children: [

                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro( ct: rc,)));
                      },style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.lightBlue[50])
                      ), child:  Text("Começar") ),
                        ElevatedButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Listagem(rc: rc)));

                        },child: Text("Lista"), )
                      ])
                    ),


                  ]

              )
          ),



        )
    );
  }
}



