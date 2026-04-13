import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String _keyFirstTime = 'is_first_time';
  static const String _keyIntroShown = 'intro_shown';

  /// Sets the flag indicating the intro has been shown and it's no longer the first time
  static Future<void> setIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIntroShown, true);
    await prefs.setBool(_keyFirstTime, false);
  }

  /// Checks if it's the user's first time or if the intro needs to be shown
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstTime) ?? true;
  }

  /// Checks if the intro has been shown
  static Future<bool> isIntroShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIntroShown) ?? false;
  }

  /// Reset all flags (useful for debugging/testing)
  static Future<void> resetFlags() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFirstTime);
    await prefs.remove(_keyIntroShown);
  }
}
