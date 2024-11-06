import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String favoriteKey = "favorite_users";

  static Future<void> saveFavoriteUsers(List<String> userIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(favoriteKey, json.encode(userIds));
  }

  static Future<List<String>> getFavoriteUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(favoriteKey);
    if (jsonString != null) {
      return List<String>.from(json.decode(jsonString));
    }
    return [];
  }
}
