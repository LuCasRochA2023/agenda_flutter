import 'package:agenda/entity/contato.dart';
import 'package:agenda/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:agenda/screen/change.dart';
  class Listagem extends StatefulWidget{
    final Repository rc;
    Listagem({required this.rc});
    @override
     State<Listagem> createState() => ListagemState(rc:rc);
  }

  class ListagemState extends State<Listagem> {

    final Repository rc;

    ListagemState({required this.rc});

    @override
    Widget build(BuildContext context) {
      List<Contato> contatos = rc.getContatos(); // Método síncrono

      return Scaffold(
        appBar: AppBar(
          title: Text("Lista de contatos"),
        ),
        body: contatos.isEmpty
            ? Center(child: Text('Nenhum contato disponível'))
            : ListView.builder(
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            Contato contato = contatos[index];
            return ListTile(
              title: Text(contato.nome),
              subtitle: Text(
                  "-Telefone: ${contato.telefone}\n-Email: ${contato.email}"),
              onTap: () async {
                final altCad = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Alterar(
                          rc: rc, contato: contato, index: index,
                        ),
                  ),
                );
                if (altCad == true) {
                  setState(() {});
                }
              },
            );
          },
        ),
      );
    }
  }