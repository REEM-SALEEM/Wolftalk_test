import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wolf_pack_test/constants/color/colors.dart';
import 'package:wolf_pack_test/controller/chat_prov.dart';
import 'package:wolf_pack_test/services/database_services.dart';

messageTile(
    {BuildContext? context, required DocumentSnapshot doc, dynamic sentByMe}) {
  sentByMe =
      doc['senderID'] == DatabaseService().getCurrentUser()!.uid ? true : false;
  return Container(
    padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: sentByMe == true ? 0 : 24,
        right: sentByMe == true ? 24 : 0),
    alignment: sentByMe == true ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: sentByMe == true
          ? const EdgeInsets.only(left: 30)
          : const EdgeInsets.only(right: 30),
      padding: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: sentByMe == true
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          color: sentByMe == true ? kprimary : Colors.grey[700]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(doc["message"],
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16, color: kWhite)),
          Text(
              ChatProv()
                      .formatTimestampForDisplay(doc["timestamp"].toString()) ??
                  '',
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 13, color: kWhite))
        ],
      ),
    ),
  );
}
