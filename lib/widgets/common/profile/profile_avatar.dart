import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String assetPath;

  const ProfileAvatar({super.key, required this.assetPath});

  bool isNetworkImage(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[300],
      backgroundImage: assetPath.isNotEmpty
          ? (isNetworkImage(assetPath)
              ? NetworkImage(assetPath)
              : AssetImage(assetPath)) as ImageProvider
          : null,
      child: assetPath.isEmpty
          ? const Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            )
          : null,
    );
  }
}
