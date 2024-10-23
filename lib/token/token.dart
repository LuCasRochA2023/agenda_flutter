import 'package:shared_preferences/shared_preferences.dart';

Future<bool> salvarDados(String chave, String valor) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chave, valor);
    return true;
  } catch (e) {
    print('Erro ao salvar dados: $e');
    return false;
  }
}

Future<String?> carregarDados(String chave) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(chave);
}

Future<void> removerDados(String chave) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(chave);
}