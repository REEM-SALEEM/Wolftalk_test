import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class ProfileProv extends ChangeNotifier {
  SharedPrefsProv sharedPrefs = SharedPrefsProv();
  TextEditingController bioController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  String? sEmail;
  String? sMobile;
  QuerySnapshot? snapshot;

  getUserDetails(BuildContext context) async {
    isLoading = true;
    sEmail = await sharedPrefs.getUserEmail();
    sMobile = await sharedPrefs.getUserMobile();
    log('sEmail --> $sEmail');
    log('sMobile --> $sMobile');

    if (sEmail != null || sMobile != null || snapshot != null) {
      snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(sEmail, sMobile);

      bioController = TextEditingController(text: snapshot!.docs[0]['bio']);
      mobileController =
          TextEditingController(text: snapshot!.docs[0]['mobile']);
      emailController = TextEditingController(text: snapshot!.docs[0]['email']);
      fullNameController =
          TextEditingController(text: snapshot!.docs[0]['fullName']);

      notifyListeners();
    }
    isLoading = false;
  }

  updateUserDetails() async {
    isLoading = true;

    log('userid check --> ${bioController.text}');
    if (snapshot != null && snapshot!.docs.isNotEmpty) {
      await DatabaseService(uid: snapshot!.docs[0]['uid']).updateUserData(
          bio: bioController.text.isNotEmpty
              ? bioController.text
              : snapshot!.docs[0]['bio'],
          email: emailController.text.isNotEmpty
              ? emailController.text
              : snapshot!.docs[0]['email'],
          fullName: fullNameController.text.isNotEmpty
              ? fullNameController.text
              : snapshot!.docs[0]['fullName'],
          mobile: mobileController.text.isNotEmpty
              ? mobileController.text
              : snapshot!.docs[0]['mobile'],
          groups: snapshot!.docs[0]['groups'],
          profilepic: snapshot!.docs[0]['profilePic']);
    }

    isLoading = false;
  }
}
