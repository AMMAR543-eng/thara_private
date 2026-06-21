import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  late SharedPreferences _preferences;

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setData<T>(String key, T data) async {
    try {
      String jsonData = json.encode(data);
      return await _preferences.setString(key, jsonData);
    } catch (e) {
      return false;
    }
  }

  T? getData<T>(String key) {
    try {
      String? jsonData = _preferences.getString(key);
      if (jsonData != null) {
        return json.decode(jsonData) as T;
      }
    } catch (e) {}
    return null;
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }
}

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  factory SecureStorageService() {
    return _instance;
  }

  SecureStorageService._internal();

  Future<bool> setData<T>(String key, T data) async {
    try {
      final String jsonData = json.encode(data);
      await _secureStorage.write(key: key, value: jsonData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<T?> getData<T>(String key) async {
    try {
      final String? jsonData = await _secureStorage.read(key: key);
      if (jsonData != null) {
        return json.decode(jsonData) as T;
      }
    } catch (e) {}
    return null;
  }

  Future<bool> remove(String key) async {
    try {
      await _secureStorage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
