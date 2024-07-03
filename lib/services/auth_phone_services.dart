import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class AuthPhoneService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  signInWithPhone(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {},
        codeSent: (verificationId, int? forceResendingToken) {
          Navigator.of(context)
              .pushNamed('/otp_screen', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        phoneNumber: phoneNumber);
  }

  Future<UserCredential?> verifyOTP(BuildContext context,
      {required String? otp, required String? verificationID}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID!, smsCode: otp!);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null &&
          userCredential.additionalUserInfo!.isNewUser == true) {
        await DatabaseService(uid: userCredential.user!.uid).savingUserData(
          mobile: userCredential.user!.providerData.first.phoneNumber,
        );
      }
      log('user --> ${userCredential.user!}');
      return userCredential;
    } catch (e) {
      log("failed to verify otp ${e.toString()}");
    }
    return null;
  }

  void signOutPhone() async {
    await FirebaseAuth.instance.signOut();
  }
}
