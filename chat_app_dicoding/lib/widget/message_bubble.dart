import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMyChat;

  MessageBubble({this.sender, this.text, this.isMyChat});

  final senderBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );

  final otherBorderRadius = BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: isMyChat ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            color: isMyChat ? Colors.lightBlue : Colors.white,
            borderRadius: isMyChat ? senderBorderRadius : otherBorderRadius,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                text,
                style: TextStyle(
                  color: isMyChat ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
