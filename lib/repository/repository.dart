import 'package:agenda/data/data_dao.dart';

import '../entity/contato.dart';

class Repository {
  final List<Contato> contatos = [];
  void addContato(DataDao dataDao, String nome, String telefone, String email) {
    Contato novoContato = Contato(nome: nome, telefone: telefone, email: email);


    dataDao.save(novoContato);


    contatos.add(novoContato);
  }
  List<Contato> getContatos() {
    return contatos;
  }
  void atualizarContato(Contato contato, int index) {
    DataDao dataDao = DataDao();
    dataDao.atualizarContato(contato);

    contatos[index] = contato;
  }

  void removerContato(Contato c) {
    contatos.remove(c);
  }
}
