import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_keys.dart';

abstract class LocalStorageService {
  static const String _hasSeenOnboardKey = 'hasSeenOnboard';

  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<void> remove(String key);
  Future<void> clear();
  
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(LocalStorageKeys.userId);
    await prefs.remove(LocalStorageKeys.userEmail);
    await prefs.remove(LocalStorageKeys.userName);
    await prefs.remove(LocalStorageKeys.userPhotoUrl);
    await prefs.remove(LocalStorageKeys.authToken);
    await prefs.remove(_hasSeenOnboardKey); // Resetear onboard al cerrar sesión
  }

  static Future<void> setHasSeenOnboard(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardKey, value);
  }

  static Future<bool> hasSeenOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardKey) ?? false;
  }
}

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageServiceImpl(this._prefs);

  @override
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
