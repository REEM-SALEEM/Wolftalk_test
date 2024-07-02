import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wolf_pack_test/view/otp_screen.dart';

class AuthPhoneService {
  signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {},
        codeSent: (verificationId, int? forceResendingToken) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OTPScreen(
              verificationID: verificationId,
            ),
          ));
        },
        //After otp expires
        codeAutoRetrievalTimeout: (verificationId) {},
        phoneNumber: phoneNumber);
  }

  Future<UserCredential?> verifyOTP(BuildContext context,
      {required String? otp, required String? verificationID}) async {
    try {
      PhoneAuthCredential credentials = PhoneAuthProvider.credential(
          verificationId: verificationID!, smsCode: otp!);

      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void signOutPhone() async {
    await FirebaseAuth.instance.signOut();
  }
}
