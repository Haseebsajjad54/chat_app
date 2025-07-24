import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/Widgets/chat_bubble.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userUid;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userUid,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = AuthService();
  final _chatService = ChatServices();
  final TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text(
                'Error',
                textAlign: TextAlign.center,
              ),
              content: const Text('Please type something...'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.done),
                )
              ],
            ),
      );
    } else {
      _chatService.sendMessage(widget.userUid, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
      body: Column(
        children: [
          Expanded(
              child: _buildMessageList()
          ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file_outlined
                    )
                ),
                hintText: 'Type to send message....',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(

            backgroundColor: Colors.green,
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    String senderID = _auth.getCurrentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderID, widget.userUid),
      builder: (context, snapShot) {
        if (snapShot.hasError) {
          return const Center(
            child: Text(
              'Error...!!!!',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading.....', style: TextStyle(fontSize: 20)),
                SizedBox(width: 5),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return ListView(
            children: snapShot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _auth.getCurrentUser!.uid;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        mainAxisAlignment:
        isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7, // max 70% of screen
            ),
            child: ChatBubble(
              message: data['message'],
              isCurrentUser: isCurrentUser,
            ),
          ),
        ],
      ),
    );
  }
}

