import 'package:chat_app/Models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices{

  final  _fireStore = FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;
  // get User data

Stream<List<Map<String,dynamic>>> getUserStream (){
  return _fireStore.collection("Users").snapshots().map(
      (snapShot){
        return snapShot.docs.map(
            (doc){
              final user=doc.data();
              return user;
            }
        ).toList();
      }
  );

}

// Send Messages
Future<void> sendMessage(String receiverID,String message) async {
  // get the current User

  String currentUserId= _auth.currentUser!.uid;
  final String? currentUserEmail= _auth.currentUser!.email;
  final Timestamp timestamp=Timestamp.now();

  // Create New Message
  Message newMessage=Message(
                              receiverId: receiverID,
                              senderEmail: currentUserEmail!,
                              senderId: currentUserId,
                              message: message,
                              timestamp: timestamp,
                               isRead:false

  );
  // Create a New Chat room
  List<String> ids=[receiverID,currentUserId];
  ids.sort();

  String chatRoomId=ids.join('_');

  //add new messages to the database
 await _fireStore.collection('chat_rooms')
                 .doc(chatRoomId)
                 .collection('messages')
                 .add(newMessage.toMap());
}
// Receive Messages
Stream<QuerySnapshot> getMessages(String userID,otherUserID) {

    List<String>ids=[userID,otherUserID];
    ids.sort();
    String chatRoomID=ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timeStamp',descending: false)
        .snapshots();
}
  void markMessagesAsRead(String chatId, String currentUserId) async {
    final messages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in messages.docs) {
      doc.reference.update({'isRead': true});
    }
  }
  Future<int> getUnreadCount(String chatId, String currentUserId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('receiverId', isEqualTo: currentUserId)
        .where('isRead', isEqualTo: false)
        .get();

    return querySnapshot.docs.length;
  }



}