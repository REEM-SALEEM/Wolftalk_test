import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? senderID;
  final String? senderName;
  final String? receiverID;
  final String? message;
  final Timestamp? timestamp;

  Message({
    required this.senderID,
    required this.senderName,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderName,
      "receiverID": receiverID,
      "message": message,
      "timestamp": timestamp
    };
  }
}
