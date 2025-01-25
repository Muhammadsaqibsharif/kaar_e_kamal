import 'package:flutter/material.dart';

class UserInfoForm extends StatelessWidget {
  const UserInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Full Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: textStyle,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email Address",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: textStyle,
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Phone Number",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: textStyle,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add form submission logic
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
