import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';

class SplashProv extends ChangeNotifier {
  SharedPrefsProv sharedPrefs = SharedPrefsProv();
  bool? isLoggedIn;
  bool? isNamed;
  Future navigateTo(BuildContext context) async {
    isLoggedIn = await sharedPrefs.getIsLoggedIn();
    isNamed = await sharedPrefs.getIsNamed();

    log('isLoggedIn --> ${isLoggedIn.toString()}');
    log('isNamed --> ${isNamed.toString()}');

    if (isLoggedIn == true && isNamed == true) {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home_screen", (route) => false);
      });
    } else if (isLoggedIn == true && isNamed == false) {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/welcome_screen", (route) => false);
      });
    } else {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login_screen", (route) => false);
      });
    }
  }
}
