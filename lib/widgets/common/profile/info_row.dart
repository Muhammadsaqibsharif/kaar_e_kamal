import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the entire row
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10), // Space between label and value
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center, // Ensures value is center-aligned
              overflow: TextOverflow.ellipsis, // Prevents overflow issues
            ),
          ),
        ],
      ),
    );
  }
}
