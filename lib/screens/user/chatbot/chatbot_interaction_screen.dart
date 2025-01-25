import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/user/chatbot/chat_input_field.dart';
import 'package:kaar_e_kamal/widgets/user/chatbot/chatbot_message_bubble.dart';

class ChatbotInteractionScreen extends StatefulWidget {
  @override
  _ChatbotInteractionScreenState createState() =>
      _ChatbotInteractionScreenState();
}

class _ChatbotInteractionScreenState extends State<ChatbotInteractionScreen> {
  // List to hold chat messages
  List<String> messages = [
    "Hello! How can I assist you today?",
  ];

  final TextEditingController _controller = TextEditingController();

  // Function to send a message
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear(); // Clear the input field after sending the message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Interaction'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatMessageBubble(message: messages[index]);
              },
            ),
          ),
          ChatInputField(
            controller: _controller,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}
