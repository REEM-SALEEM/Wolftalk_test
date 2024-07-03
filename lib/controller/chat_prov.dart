import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wolf_pack_test/controller/sharedprefs_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';
import 'package:intl/intl.dart';

class ChatProv extends ChangeNotifier {
  SharedPrefsProv sharedPrefs = SharedPrefsProv();
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  ScrollController scrollController = ScrollController();
  String? sEmail;
  String? sMobile;
  QuerySnapshot? snapshot;

  sendMessage(String receiverID) async {
    sEmail = await sharedPrefs.getUserEmail();
    sMobile = await sharedPrefs.getUserMobile();
    log('sEmail --> $sEmail');
    log('sMobile --> $sMobile');
    snapshot =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .gettingUserData(sEmail, sMobile);
    if (sEmail != null || sMobile != null || snapshot != null) {
      await DatabaseService().sendMessage(
          receiverID, messageController.text, snapshot?.docs[0]['fullName']);
    }
    messageController.clear();
  }

  void scrollToBottom() {
    // Ensure the scroll controller is attached to a scroll view
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      // Try again after a short delay if not attached yet
      Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
    }
  }

  String? formatTimestampForDisplay(dynamic timestampString) {
    String stamp = timestampString;

    // Extract seconds and nanoseconds from the string
    RegExp regExp = RegExp(r'Timestamp\(seconds=(\d+), nanoseconds=(\d+)\)');
    Match match = regExp.firstMatch(stamp) as Match;

    if (match != null) {
      int seconds = int.parse(match.group(1)!);
      int nanoseconds = int.parse(match.group(2)!);

      Timestamp timestamppp = Timestamp(seconds, nanoseconds);

      DateTime a = timestamppp.toDate();

      int timestamp = DateTime.parse(a.toString()).millisecondsSinceEpoch;

      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));
      final beforeYesterday = today.subtract(Duration(days: 2));

      if (dateTime.isAfter(today)) {
        return 'today, ${DateFormat('h:mm a').format(dateTime)}';
      } else if (dateTime.isAfter(yesterday)) {
        return 'yesterday, ${DateFormat('h:mm a').format(dateTime)}';
      } else if (dateTime.isAfter(beforeYesterday)) {
        return '${DateFormat('MMMM d, h:mm a').format(dateTime)}';
      } else {
        return '${DateFormat('MMMM d, h:mm a').format(dateTime)}';
      }
    }
  }
}
