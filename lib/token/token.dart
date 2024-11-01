import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
final FlutterSecureStorage secureStorage = FlutterSecureStorage();
Future<void> salvarToken(String token) async {
  await secureStorage.write(key: 'authToken', value: token);
}

Future<String?> lerToken() async {
  return await secureStorage.read(key: 'authToken');
}

Future<void> deletarToken() async {
  await secureStorage.delete(key: 'authToken');
}
// Future<bool> salvarDados(String chave, String valor) async {
// //   try {
// //     final prefs = await SharedPreferences.getInstance();
// // //     await prefs.setString(chave, valor);
// // //     return true;
// //   } catch (e) {
// //     print('Erro ao salvar dados: $e');
// //     return false;
// //   }
// // }
// //
// // Future<String?> carregarDados(String chave) async {
// //   final prefs = await SharedPreferences.getInstance();
// //   return prefs.getString(chave);
// // }
// //
// // Future<void> removerDados(String chave) async {
// //   final prefs = await SharedPreferences.getInstance();
// //   await prefs.remove(chave);
// }