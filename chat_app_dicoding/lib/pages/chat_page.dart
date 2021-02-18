import 'package:chat_app_dicoding/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_page';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User _activeUser;
  
  final _messageTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      var currentUser = await _auth.currentUser;
      if(currentUser != null) {
        _activeUser = currentUser;
      }
    }catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, LoginPage.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('dateCreated', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final messages = snapshot.data.docs;
                  List<MessageBubble> messageBubbles = [];
                  for(var message in messages) {
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];

                    final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      isMyChat: messageSender == _activeUser.email,
                    );
                    messageBubbles.add(messageBubble);
                  }
                  return ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    children: messageBubbles,
                  );
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                MaterialButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  child: Text('SEND'),
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  void _sendMessage() {
    _firestore.collection('messages').add({
      'text' : _messageTextController.text,
      'sender' : _activeUser.email,
      'dateCreated' : Timestamp.now(),
    });
    _messageTextController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageTextController.dispose();
    super.dispose();
  }

}
