import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;

  const ChatMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF31511E), // Dark Green for the message bubble
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white, // White text for the message
            ),
          ),
        ),
      ),
    );
  }
}
