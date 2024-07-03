import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wolf_pack_test/model/message_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chat_rooms");

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // saving the userdata
  Future savingUserData({
    String? fullName,
    String? email,
    String? bio,
    String? mobile,
    String? profilepic,
  }) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName ?? '',
      "email": email ?? '',
      "groups": [],
      "profilePic": profilepic ?? "",
      "uid": uid,
      "mobile": mobile,
      "bio": bio ?? "",
    });
  }

  // update the Username
  Future updateUserName({
    String? fullName,
  }) async {
    try {
      return await userCollection.doc(uid).update(
        {
          "fullName": fullName,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  // update the userdata
  Future updateUserData({
    String? fullName,
    String? email,
    String? mobile,
    String? profilepic,
    List<dynamic>? groups,
    String? bio,
  }) async {
    try {
      return await userCollection.doc(uid).update(
        {
          "fullName": fullName,
          "email": email,
          "groups": groups,
          "profilePic": profilepic,
          "uid": uid,
          "mobile": mobile,
          "bio": bio,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  // getting user data
  Future gettingUserData(String? email, String? mobile) async {
    QuerySnapshot snapshot = email != null && email.isNotEmpty
        ? await userCollection.where("email", isEqualTo: email).get()
        : await userCollection.where("mobile", isEqualTo: mobile).get();
    return snapshot;
  }

  // get user groups

  Stream<List<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((snapshots) {
      return snapshots.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(
      String receiverID, message, String currentUserName) async {
// get current user details
    final String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    //new msg
    Message newMessage = Message(
        senderID: FirebaseAuth.instance.currentUser!.uid,
        senderName: currentUserName,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //chat room for 2 users
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    log('receiverID --> ${receiverID}\n chatRoomID --> ${chatRoomID}');
    // add to DB
    await chatCollection
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  String? chatRoomID;
  getMessage(String userID, otherUserID) {
    print('getting msg');
    //chat room for 2 users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    chatRoomID = ids.join("_");
    dynamic abc = chatCollection
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
    return abc;
  }
}
