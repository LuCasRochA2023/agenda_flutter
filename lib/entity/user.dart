class User {
  String usuario;
  String senha;

  User({required this.usuario, required this.senha, });
  Map<String, dynamic?> toMap() {
    return {'nome': usuario, 'senha': senha};
  }

}