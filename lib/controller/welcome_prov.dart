import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/widgets/snackbar_widget.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class WelcomeProv extends ChangeNotifier {
  SharedPrefsProv sharedPrefs = SharedPrefsProv();

  TextEditingController nameController = TextEditingController();

  String? sEmail;

  updateName(BuildContext context) async {
    // shared prefs
    sEmail = await sharedPrefs.getUserEmail();

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .updateUserName(fullName: nameController.text)
        .then((value) async {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/home_screen", (route) => false);
      showSnackbar(context, Colors.green, "Login successful.");

      await sharedPrefs.saveUserName(nameController.text);
      await sharedPrefs.saveIsNamed(true);
      nameController.clear();
    });
  }
}
