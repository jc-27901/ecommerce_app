import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefSingleton {
  static SharedPrefSingleton? _instance;
  static SharedPreferences? _prefs;

  // Private constructor
  SharedPrefSingleton._();

  // Factory constructor to return the same instance every time
  factory SharedPrefSingleton() => _instance ??= SharedPrefSingleton._();

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Generic method to save data
  static Future<bool> setData<T>(String key, T value) async {
    if (_prefs == null) return false;

    if (T == String) {
      return await _prefs!.setString(key, value as String);
    } else if (T == int) {
      return await _prefs!.setInt(key, value as int);
    } else if (T == double) {
      return await _prefs!.setDouble(key, value as double);
    } else if (T == bool) {
      return await _prefs!.setBool(key, value as bool);
    } else if (T == List<String>) {
      return await _prefs!.setStringList(key, value as List<String>);
    } else {
      // For complex objects, convert to JSON string
      String jsonString = json.encode(value);
      return await _prefs!.setString(key, jsonString);
    }
  }

  // Generic method to retrieve data
  static T? getData<T>(String key) {
    if (_prefs == null) return null;

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
      // For complex objects, retrieve JSON string and decode
      String? jsonString = _prefs!.getString(key);
      if (jsonString != null) {
        return json.decode(jsonString) as T?;
      }
    }
    return null;
  }

  // Method to remove data
  static Future<bool> removeData(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  // Method to clear all data
  static Future<bool> clearAll() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }
}