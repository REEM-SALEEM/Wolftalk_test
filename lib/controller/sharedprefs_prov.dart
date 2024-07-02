import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProv extends ChangeNotifier {
  Future<void> saveBool(String key, bool value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      notifyListeners();
    } catch (e) {
      debugPrint("Error saving bool to SharedPreferences: $e");
    }
  }

  Future<bool> getBool(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? boolValue = prefs.getBool(key);
      return boolValue ?? false;
    } catch (e) {
      debugPrint("Error retrieving bool from SharedPreferences: $e");
      return false;
    }
  }

  Future<void> saveString(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      notifyListeners();
    } catch (e) {
      debugPrint("Error saving string to SharedPreferences: $e");
    }
  }

  Future<void> clear() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      notifyListeners();
    } catch (e) {
      debugPrint("Error saving string to SharedPreferences: $e");
    }
  }

  Future<String?> getString(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      debugPrint("Error retrieving string from SharedPreferences: $e");
      return null;
    }
  }
}
