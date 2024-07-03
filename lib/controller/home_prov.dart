import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

class HomeProv extends ChangeNotifier {
  SharedPrefsProv sharedPrefs = SharedPrefsProv();
  TextEditingController groupNameController = TextEditingController();
  bool isLoading = false;
  String? sEmail;
  String? sMobile;
  String? sName;

  Stream? users;
  QuerySnapshot? snapshot;

  Future<bool> getMessage(BuildContext context,
      {required dynamic userData}) async {
    getUsername(context);
    List<String> ids = [
      userData['uid'],
      FirebaseAuth.instance.currentUser!.uid
    ];
    ids.sort();
    String chatRoomIDD = ids.join("_");
    log(chatRoomIDD);
    try {
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomIDD)
          .collection('messages');

      // Fetch all messages
      QuerySnapshot querySnapshot = await messagesRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.of(context).pushNamed('/chat_screen', arguments: {
          'receiverEmail': userData["fullName"],
          'receiverID': userData["uid"],
        });

        print("Chat room exists.");
        return true;
      } else {
        Navigator.of(context).pushNamed('/connection_profile',
            arguments: {'userData': userData});

        print("Chat room does not exist.");
        return false;
      }
    } catch (e) {
      print("Error checking chat room existence: $e");
      return false;
    }
  }

  getUsername(BuildContext context) async {
    // shared prefs
    sEmail = await sharedPrefs.getUserEmail();
    sMobile = await sharedPrefs.getUserMobile();

    snapshot =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .gettingUserData(sEmail, sMobile);
    users = DatabaseService().getUsers();

    sName = await snapshot!.docs[0]['fullName'];
    await sharedPrefs.saveUserName(sName!);
  }

  // createGroup(BuildContext context) {
  //   if (groupName != "") {
  //     isLoading = true;
  //     DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //         .createGroup(
  //             sName!, FirebaseAuth.instance.currentUser!.uid, groupName)
  //         .whenComplete(() {
  //       isLoading = false;
  //     });
  //     Navigator.of(context).pop();
  //     groupNameController.clear();
  //     showSnackbar(context, Colors.green, "Group created successfully.");
  //   }
  //   notifyListeners();
  // }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getMsg(String res) {
    return res.substring(res.indexOf("_") + 1);
  }
}
