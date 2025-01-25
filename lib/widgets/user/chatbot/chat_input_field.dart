import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;

  const ChatInputField({
    required this.controller,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomInputField(
              controller: controller,
              label: 'Type a message...',
              hint: 'Your message here...',
              onSaved: (value) {},
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Color(0xFF31511E), // Dark Green send icon
            ),
            onPressed: onSendMessage,
          ),
        ],
      ),
    );
  }
}
