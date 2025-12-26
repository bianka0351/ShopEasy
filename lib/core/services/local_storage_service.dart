import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyIsLoggedIn = 'isLoggedIn';

  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  Future<void> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  String? get username => prefs.getString(_keyUsername);
  String? get email => prefs.getString(_keyEmail);
  String? get password => prefs.getString(_keyPassword);

  Future<void> clear() async {
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
  }

  bool get hasUser =>
      prefs.containsKey(_keyEmail) && prefs.containsKey(_keyPassword);

  bool validateLogin(String email, String password) {
    return this.email == email && this.password == password;
  }

  Future<void> setLoggedIn(bool value) async {
    await prefs.setBool(_keyIsLoggedIn, value);
  }

  bool get isLoggedIn => prefs.getBool(_keyIsLoggedIn) ?? false;

  Future<void> updateUsername(String newUsername) async {
    await prefs.setString(_keyUsername, newUsername);
  }

  Future<void> updateEmail(String newEmail) async {
    await prefs.setString(_keyEmail, newEmail);
  }

  Future<void> updatePassword(String newPassword) async {
    await prefs.setString(_keyPassword, newPassword);
  }
}
