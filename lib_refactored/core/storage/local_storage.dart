import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _prefs;
  
  LocalStorage._();
  
  static Future<LocalStorage> get instance async {
    _instance ??= LocalStorage._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }
  
  // Initialize storage
  static Future<void> init() async {
    await instance;
  }
  
  // Generic save method
  Future<bool> saveData<T>({
    required String key,
    required T value,
  }) async {
    try {
      if (value is String) {
        return await _prefs!.setString(key, value);
      } else if (value is int) {
        return await _prefs!.setInt(key, value);
      } else if (value is double) {
        return await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        return await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        return await _prefs!.setStringList(key, value);
      } else {
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
      }
    } catch (e) {
      print('Error saving data: $e');
      return false;
    }
  }
  
  // Generic get method
  T? getData<T>({required String key}) {
    try {
      if (T == String) {
        return _prefs!.getString(key) as T?;
      } else if (T == int) {
        return _prefs!.getInt(key) as T?;
      } else if (T == double) {
        return _prefs!.getDouble(key) as T?;
      } else if (T == bool) {
        return _prefs!.getBool(key) as T?;
      } else if (T == List<String>) {
        return _prefs!.getStringList(key) as T?;
      } else {
        throw ArgumentError('Unsupported type: $T');
      }
    } catch (e) {
      print('Error getting data: $e');
      return null;
    }
  }
  
  // Remove specific key
  Future<bool> removeData({required String key}) async {
    try {
      return await _prefs!.remove(key);
    } catch (e) {
      print('Error removing data: $e');
      return false;
    }
  }
  
  // Clear all data
  Future<bool> clearAll() async {
    try {
      return await _prefs!.clear();
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }
  
  // Check if key exists
  bool hasKey(String key) {
    return _prefs!.containsKey(key);
  }
  
  // Get all keys
  Set<String> getAllKeys() {
    return _prefs!.getKeys();
  }
  
  // Auth-specific methods
  Future<bool> saveAccessToken(String token) async {
    return await saveData(key: AppConstants.accessTokenKey, value: token);
  }
  
  String? getAccessToken() {
    return getData<String>(key: AppConstants.accessTokenKey);
  }
  
  Future<bool> saveRefreshToken(String token) async {
    return await saveData(key: AppConstants.refreshTokenKey, value: token);
  }
  
  String? getRefreshToken() {
    return getData<String>(key: AppConstants.refreshTokenKey);
  }
  
  Future<bool> saveUserId(String id) async {
    return await saveData(key: AppConstants.userIdKey, value: id);
  }
  
  String? getUserId() {
    return getData<String>(key: AppConstants.userIdKey);
  }
  
  Future<bool> saveUserEmail(String email) async {
    return await saveData(key: AppConstants.userEmailKey, value: email);
  }
  
  String? getUserEmail() {
    return getData<String>(key: AppConstants.userEmailKey);
  }
  
  Future<bool> saveUserRole(String role) async {
    return await saveData(key: AppConstants.userRoleKey, value: role);
  }
  
  String? getUserRole() {
    return getData<String>(key: AppConstants.userRoleKey);
  }
  
  // Clear auth data
  Future<bool> clearAuthData() async {
    try {
      await removeData(key: AppConstants.accessTokenKey);
      await removeData(key: AppConstants.refreshTokenKey);
      await removeData(key: AppConstants.userIdKey);
      await removeData(key: AppConstants.userEmailKey);
      await removeData(key: AppConstants.userRoleKey);
      return true;
    } catch (e) {
      print('Error clearing auth data: $e');
      return false;
    }
  }
  
  // Check if user is logged in
  bool isLoggedIn() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }
  
  // User preferences
  Future<bool> saveThemeMode(String mode) async {
    return await saveData(key: 'theme_mode', value: mode);
  }
  
  String getThemeMode() {
    return getData<String>(key: 'theme_mode') ?? 'system';
  }
  
  Future<bool> saveLanguage(String language) async {
    return await saveData(key: 'language', value: language);
  }
  
  String getLanguage() {
    return getData<String>(key: 'language') ?? 'en';
  }
  
  // App settings
  Future<bool> saveNotificationsEnabled(bool enabled) async {
    return await saveData(key: 'notifications_enabled', value: enabled);
  }
  
  bool getNotificationsEnabled() {
    return getData<bool>(key: 'notifications_enabled') ?? true;
  }
  
  Future<bool> saveBiometricEnabled(bool enabled) async {
    return await saveData(key: 'biometric_enabled', value: enabled);
  }
  
  bool getBiometricEnabled() {
    return getData<bool>(key: 'biometric_enabled') ?? false;
  }
}