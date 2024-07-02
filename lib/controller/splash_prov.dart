import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/view/home_screen.dart';
import 'package:wolf_pack_test/view/login_screen.dart';

class SplashProv extends ChangeNotifier {
  bool? isLoggedIn;
  Future navigateTo(BuildContext context) async {
    isLoggedIn = await Provider.of<SharedPrefsProv>(context, listen: false)
        .getBool('isLoggedIn');
    log('bool --> ${isLoggedIn.toString()}');

    if (isLoggedIn == true) {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      });
    } else {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      });
    }
  }
}
