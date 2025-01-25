import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String assetPath;

  const ProfileAvatar({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage(assetPath),
      backgroundColor: Colors.grey[200],
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.person,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
