import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;
  static const storage = FlutterSecureStorage();

  static read(String? key) async => await storage.read(
        key: key!,
      );

  static write(String? key, String? value) async =>
      await storage.write(key: key!, value: value);

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setString(String? key, String? value) async =>
      await _preferences!.setString(key!, value!);

  static String? getString(String key) => _preferences!.getString(key) ?? "N/A";

  static Future setBoolean(String key, bool value) async =>
      await _preferences!.setBool(key, value);

  static bool getBoolean(String key) => _preferences?.getBool(key) ?? false;

  static int getInt(dynamic key) {
    return _preferences!.getInt("$key") ?? 0;
  }

  static Future setInt(String key, int value) async {
    return await _preferences!.setInt("$key", value);
  }

  static void clearPref() {
    _preferences!.clear();
  }
}
