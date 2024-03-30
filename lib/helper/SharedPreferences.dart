import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _sharedPreferences;


  static const String name = 'name';

  static Future<SharedPreferencesManager?> getInstance() async {
    _instance ??= SharedPreferencesManager();
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  Future<bool> putString(String key, String value) => _sharedPreferences!.setString(key, value);

  String? getString(String key) => _sharedPreferences!.getString(key);

  Future<bool> clearKey(String key) => _sharedPreferences!.remove(key);
}

 
