import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProv extends ChangeNotifier {
  //---- STRING ----
  // SET STRING
  Future<void> saveUserName(String status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setString('sName', status);
  }

  Future<void> saveUserEmail(String status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setString('sEmail', status);
  }

  Future<void> saveUserMobile(String status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setString('sMobile', status);
  }

  Future<void> saveUserUid(String status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setString('sUid', status);
  }

// GET STRING
  Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('sName');
  }

  Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('sEmail');
  }

  Future<String?> getUserMobile() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('sMobile');
  }

  Future<String?> getUserUid() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString('sUid');
  }
  //---- BOOL ----
  //---- SET BOOL

  Future<void> saveIsLoggedIn(bool status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setBool('isLoggedIn', status);
  }

  Future<void> saveIsNamed(bool status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    notifyListeners();
    await sf.setBool('isNamed', status);
  }

  //---- GET BOOL
  Future<bool?> getIsLoggedIn() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool('isLoggedIn');
  }

  Future<bool?> getIsNamed() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool('isNamed');
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
}
