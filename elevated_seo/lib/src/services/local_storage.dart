import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences sharedPreferences;
  static const String AUTHSTATUS = "AUTHSTATUS";
  static const String TOKEN = "TOKEN";
  static const String INDEX = "INDEX";

  initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String> checkAuthenticatorStatus() async {
    await initialize();
    return sharedPreferences.getString(AUTHSTATUS) ?? "PENDING";
  }

  Future<void> setAuthStatus(String authStatus) async {
    await initialize();
    return sharedPreferences.setString(AUTHSTATUS, authStatus);
  }

  Future<bool> setToken(List<String> tokenData) async {
    await initialize();
    return sharedPreferences.setStringList(TOKEN, tokenData);
  }

  Future<List<String>> getToken() async {
    await initialize();
    return sharedPreferences.getStringList(TOKEN) ?? [];
  }

  Future<bool> setIndex(int data) async {
    await initialize();
    return sharedPreferences.setInt(INDEX, data);
  }

  Future<int> getIndex() async {
    await initialize();
    return sharedPreferences.getInt(INDEX) ?? 0;
  }
}
