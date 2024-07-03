import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/widgets/snackbar_widget.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/services/auth_google_service.dart';
import 'package:wolf_pack_test/services/auth_phone_services.dart';

class LoginProv extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  SharedPrefsProv sharedPrefs = SharedPrefsProv();

  TextEditingController mobileController = TextEditingController(text: '+91');
  TextEditingController otpController = TextEditingController();

// google Auth
  googleSignIn(BuildContext context) async {
    final resp = await AuthGoogleService().signInWithGoogle();
    if (resp.user != null) {
      if (resp.additionalUserInfo!.isNewUser == true && context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/welcome_screen", (route) => false);
      } else {
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home_screen", (route) => false);
          showSnackbar(context, Colors.green, "Login successful.");
          await sharedPrefs.saveIsNamed(true);
        }
      }

      // shared prefs
      await sharedPrefs.saveIsLoggedIn(true);
      await sharedPrefs.saveUserUid(resp.user!.uid);
      await sharedPrefs.saveUserEmail(resp.user!.email!);
    }
    notifyListeners();
  }

// phone Auth
  phoneSignIn(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      await sharedPrefs.saveUserMobile(mobileController.text);
      await AuthPhoneService()
          .signInWithPhone(context, phoneNumber: mobileController.text);
      otpController = TextEditingController();
    }
    notifyListeners();
  }

  verifyOTP(BuildContext context, String verificationID) async {
    try {
      final resp = await AuthPhoneService().verifyOTP(context,
          otp: otpController.text, verificationID: verificationID);

      if (resp != null && context.mounted) {
        if (resp.additionalUserInfo!.isNewUser == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/welcome_screen", (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home_screen", (route) => false);
          showSnackbar(context, Colors.green, "Login successful.");
          await sharedPrefs.saveIsNamed(true);
        }
        // shared prefs
        await sharedPrefs.saveIsLoggedIn(true);
        await sharedPrefs.saveUserMobile(mobileController.text);
        mobileController.clear();
        mobileController = TextEditingController(text: '+91');
      }
    } catch (e) {
      log(e.toString());
    }
  }

// logout
  signOut(BuildContext context) async {
    AuthGoogleService().signOutGoogle();
    AuthPhoneService().signOutPhone();
    if (context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/login_screen", (route) => false);
    }
    // shared prefs
    sharedPrefs.clear();
  }

  // validation
  validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty || value == '+91') {
      return 'Please enter a mobile number';
    } else if (!value.startsWith('+91')) {
      return 'Please add +91 at the beginning of the mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }
}
