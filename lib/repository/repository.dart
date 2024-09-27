import '../entity/Contato.dart';

class Repository {
  final List<Contato> contatos = [];

  void addContato(Contato c){
    contatos.add(c);
  } void atualizarContato(Contato novo, int local)
  {
    contatos.elementAt(local).nome = novo.nome;
    contatos.elementAt(local).telefone = novo.telefone;
    contatos.elementAt(local).email = novo.email;
  }
  List<Contato> getContatos() {
    return contatos;
  }

  void removerContato(Contato c) {
    contatos.remove(c);
  }
}
