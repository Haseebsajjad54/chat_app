import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String receiverId;
  final String senderEmail;
  final String senderId;
  final String message;
  final Timestamp timestamp;
  bool isRead;

  Message({
    required this.receiverId,
    required this.senderEmail,
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.isRead
  });

  Map<String,dynamic> toMap(){
    return{
      'senderId':senderId,
      'senderEmail':senderEmail,
      'receiverId':receiverId,
      'message':message,
      'timeStamp':timestamp,
      'isRead':isRead
    };
  }

}