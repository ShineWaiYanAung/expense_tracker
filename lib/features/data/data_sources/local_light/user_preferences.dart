import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _imageKey = 'user_profile_image';
  static const _usernameKey = 'user_name';

  /// Save username
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  /// Get username
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Save profile image path
  static Future<void> setProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageKey, path);
  }

  /// Get profile image file
  static Future<File?> getProfileImageFile() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_imageKey);
    if (path != null && File(path).existsSync()) {
      return File(path);
    }
    return null;
  }

  /// Clear all saved user data (optional)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_imageKey);
  }
}
