import "package:agenda/entity/user.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class LoginDao {
  static const String _tablename = 'users';
  static const String _id = 'id';
  static const String _username = 'username';
  static const String _password = 'password';

  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_username TEXT NOT NULL,'
      '$_password TEXT NOT NULL)';

  Future<Database> getDataBase() async {
    final String path = join(await getDatabasesPath(), 'data.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(tableSql); // Criação da tabela
      },
      version: 2,
    );
  }

  List<User> toList(List<Map<String, dynamic>> listaDeLogins) {
    final List<User> lista = [];
    for (Map<String, dynamic> linha in listaDeLogins) {
      final User login = User(usuario: linha[_username], senha: linha[_password]);
      lista.add(login);
    }
    return lista;
  }

  Map<String, dynamic> toMap(User user) {
    return {
      _username: user.usuario,
      _password: user.senha,
    };
  }

  Future<int> save(User login) async {
    final Database database = await getDataBase();
    Map<String, dynamic> loginMap = toMap(login);
    var itemExist = await find(login.usuario);
    if (itemExist.isEmpty) {
      return await database.insert(_tablename, loginMap);
    } else {
      return await database.update(
        _tablename,
        loginMap,
        where: '$_username = ?',
        whereArgs: [login.usuario],
      );
    }
  }

  Future<int> delete(String username) async {
    final Database database = await getDataBase();
    return await database.delete(_tablename, where: '$_username = ?', whereArgs: [username]);
  }

  Future<List<User>> find(String username) async {
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_username = ?',
      whereArgs: [username],
    );
    return toList(result);
  }

  Future<int> atualizarLogin(User login) async {
    final Database database = await getDataBase();
    Map<String, dynamic> loginMap = toMap(login);
    return await database.update(
      _tablename,
      loginMap,
      where: '$_username = ?',
      whereArgs: [login.usuario],
    );
  }

  Future<bool> validateUser(String username, String password) async {
    final List<User> users = await find(username);
    return users.isNotEmpty && users[0].senha == password;
  }
}
