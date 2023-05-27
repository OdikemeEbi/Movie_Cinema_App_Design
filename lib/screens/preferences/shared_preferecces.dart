import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';

  static Future<void> saveUserCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  static Future<void> clearUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
  }
}

//Video Preferences

class SharedPreferencesManager {
  static const String _keyWatchedList = 'watchedList';

  Future<List<String>> getWatchedList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? watchedList = prefs.getStringList(_keyWatchedList);
    return watchedList ?? [];
  }

  Future<void> addToWatchedList(List<String> videos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyWatchedList, videos);
  }

  Future<void> clearWatchedList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyWatchedList);
  }
}
