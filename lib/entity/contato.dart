  class Contato{
    String nome;
    String telefone;
    String email;

    Contato({required this.nome, required this.email, required this.telefone});


  Map<String, dynamic?> toMap() {
    return {'nome': nome, 'telefone': telefone, 'email': email};
  }

  }