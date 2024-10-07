import "package:agenda/entity/Contato.dart";
import "package:sqflite/sqflite.dart";
import "package:sqflite/sqlite_api.dart";
import "package:path/path.dart";

class DataDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
  '$_name TEXT,'
  '$_email TEXT,'
  '$_tel INTEGER)';

  static const String _tablename = 'contato';
  static const String _name = 'nome';
  static const String _email = 'email';
  static const String _tel = 'telefone';

  Future<Database>getDataBase()async{
    final String path = join(await getDatabasesPath(), 'data.db');
    return await openDatabase(path, onCreate: (db, version){
      return db.execute(DataDao.tableSql);


    }, version: 1,);

  }
  List<Contato>toList(List<Map<String, dynamic>> listaDeContatos){
    final List<Contato> lista = [];
    for(Map<String, dynamic> linha in listaDeContatos){
      final Contato contato = Contato(nome: linha[_name], telefone: linha[_tel], email: linha[_email]);
      lista.add(contato);
    }
    return lista;
  }
  Map<String, dynamic> toMap(Contato contato) {
    print('Convertendo contato em map');
    final Map<String, dynamic> mapaDeContatos = Map();
    mapaDeContatos[DataDao._name] = contato.nome;
    mapaDeContatos[DataDao._email] = contato.email;
    mapaDeContatos[DataDao._tel] = contato.telefone;
    return mapaDeContatos;
  }
  save(Contato contato) async {
    print('Iniciando o save: ');
    final Database database = await getDataBase();
    Map<String, dynamic> contatoMap = toMap(contato);
    var itemExist = await find(contato.nome);
    if (itemExist.isEmpty) {
      print('O contato não existia');
      return await database.insert(_tablename, contatoMap);
    } else {
      print('A tarefa já existia!');
      return await database.update(_tablename, contatoMap,
          where: '$_name = ?', whereArgs: [contato.nome]);
    }

  }
  delete(String nomeContato) async {
    print('Estamos deletado tarefa: $nomeContato');
    final Database database = await getDataBase();
    return database.delete(_tablename, where: '_name = ?',
        whereArgs: [nomeContato]);
  }
  Future<List<Contato>> find(String nomeContato) async {
    print('Acessando find: ');
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result = await database.query(
        _tablename,
        where: '$_name = ?',
        whereArgs: [nomeContato]);
    print('Contato encontrado ${toList(result)}');
    return toList(result);
  }
  Future<int> atualizarContato(Contato contato) async {
    print('Atualizando contato: ${contato.nome}');
    final Database database = await getDataBase();
    Map<String, dynamic> contatoMap = toMap(contato);


    return await database.update(
      _tablename,
      contatoMap,
      where: '$_name = ?',
      whereArgs: [contato.nome],
    );
  }


}