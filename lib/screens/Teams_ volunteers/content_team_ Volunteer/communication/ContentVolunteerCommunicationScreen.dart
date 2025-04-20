import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContentVolunteerCommunicationScreen extends StatefulWidget {
  const ContentVolunteerCommunicationScreen({super.key});

  @override
  State<ContentVolunteerCommunicationScreen> createState() =>
      _ContentVolunteerCommunicationScreenState();
}

class _ContentVolunteerCommunicationScreenState
    extends State<ContentVolunteerCommunicationScreen> {
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      "from": "leader",
      "text": "Hello, feel free to reach out!",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 5))
    },
    {
      "from": "me",
      "text": "Thank you! I had a question regarding a post.",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 3))
    },
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        "from": "me",
        "text": text,
        "timestamp": DateTime.now(),
      });
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent, // Set background to transparent
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: theme.primaryColor,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = messages.length - 1 - index;
                final message = messages[reversedIndex];
                final isMe = message["from"] == "me";
                final timestamp = message["timestamp"] is DateTime
                    ? message["timestamp"] as DateTime
                    : DateTime.now();

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      gradient: isMe
                          ? LinearGradient(
                              colors: [
                                theme.primaryColor.withOpacity(0.8),
                                theme.primaryColor.withOpacity(1)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [
                                theme.scaffoldBackgroundColor,
                                theme.primaryColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                            isMe ? const Radius.circular(16) : Radius.zero,
                        bottomRight:
                            isMe ? Radius.zero : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message["text"],
                          style: TextStyle(
                            color: isMe
                                ? Colors.white
                                : theme.textTheme.bodyMedium?.color,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('h:mm a').format(timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe
                                ? Colors.white.withOpacity(0.8)
                                : theme.textTheme.bodyMedium?.color
                                    ?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.08),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: theme.scaffoldBackgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor.withOpacity(0.8),
                          theme.primaryColor.withOpacity(1),
                        ],
                      ),
                    ),
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
