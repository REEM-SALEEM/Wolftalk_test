import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/model/user_model.dart';
import 'package:wolf_pack_test/services/auth_google_service.dart';
import 'package:wolf_pack_test/services/auth_phone_services.dart';
import 'package:wolf_pack_test/view/home_screen.dart';
import 'package:wolf_pack_test/view/login_screen.dart';
import 'package:wolf_pack_test/view/welcome_screen.dart';

class LoginProv extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController(text: '+91');
  TextEditingController otpController = TextEditingController();

  UserInfo? userDetails;

// google Auth
  googleSignIn(BuildContext context) async {
    final resp = await AuthGoogleService().signInWithGoogle();
    if (resp.user != null) {
      userDetails = UserInfo(
        displayName: resp.user!.providerData.first.displayName,
        email: resp.user!.providerData.first.email,
        phoneNumber: resp.user!.providerData.first.phoneNumber,
        photoURL: resp.user!.providerData.first.photoURL,
        providerId: resp.user!.providerData.first.providerId,
        uid: resp.user!.providerData.first.uid,
        bio: '',
      );

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
        await Provider.of<SharedPrefsProv>(context, listen: false)
            .saveBool('isLoggedIn', true);
      }
    }
    notifyListeners();
  }

// phone Auth
  phoneSignIn(BuildContext context) async {
    if (loginFormKey.currentState!.validate() && context.mounted) {
      Provider.of<SharedPrefsProv>(context, listen: false)
          .saveString('mobile', mobileController.text);
      await AuthPhoneService()
          .signInWithPhone(context, phoneNumber: mobileController.text);
    }
    notifyListeners();
  }

  verifyOTP(BuildContext context, String verificationID) async {
    try {
      final resp = await AuthPhoneService().verifyOTP(context,
          otp: otpController.text, verificationID: verificationID);

      if (resp != null && context.mounted) {
        log('newUser --> ${resp.additionalUserInfo!.isNewUser}');
        if (resp.additionalUserInfo!.isNewUser == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        }

        if (context.mounted) {
          await Provider.of<SharedPrefsProv>(context, listen: false)
              .saveBool('isLoggedIn', true);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  signOut(BuildContext context) async {
    AuthGoogleService().signOutGoogle();
    AuthPhoneService().signOutPhone();
    userDetails = UserInfo();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
      Provider.of<SharedPrefsProv>(context, listen: false).clear();
    }
  }

  // validation
  validateMobile(String value) {
    log(value);
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty || value == '+91') {
      return 'Please enter a mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }
}
