import 'package:flutter/material.dart';

class SuperAdminPresidentChatScreen extends StatefulWidget {
  const SuperAdminPresidentChatScreen({Key? key}) : super(key: key);

  @override
  _SuperAdminPresidentChatScreenState createState() =>
      _SuperAdminPresidentChatScreenState();
}

class _SuperAdminPresidentChatScreenState
    extends State<SuperAdminPresidentChatScreen> {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, String>> messages = [];

  void _sendMessage(String message, String sender) {
    if (message.isNotEmpty) {
      setState(() {
        messages.add({'sender': sender, 'message': message});
      });

      // Clear the text field after submission
      messageController.clear();

      // If the President sends a message, auto send Super Admin's reply
      if (sender == 'President') {
        Future.delayed(const Duration(seconds: 1), () {
          _sendMessage(
              "Thanks for the message. I will get back to you.", 'Super Admin');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin & President Chat'),
        backgroundColor:
            Theme.of(context).primaryColor, // Dark Green from the theme
        foregroundColor: Colors.white, // Text on AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final sender = message['sender'];
                  final msg = message['message'];

                  return Align(
                    alignment: sender == 'President'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: sender == 'President'
                              ? Theme.of(context).primaryColor // Dark Green
                              : Color(0xFF859F3D), // Olive Green
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: sender == 'President'
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            Text(
                              sender ?? 'Unknown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              msg ?? 'No message content',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: messageController,
                style:
                    const TextStyle(color: Colors.black), // Text color to black
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        _sendMessage(messageController.text, 'President');
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
