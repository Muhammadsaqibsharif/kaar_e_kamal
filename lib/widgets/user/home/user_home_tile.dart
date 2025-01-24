import 'package:flutter/material.dart';

class UserHomeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const UserHomeTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: theme.textTheme.bodyLarge),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        trailing: Icon(Icons.arrow_forward_ios, color: theme.primaryColor),
        onTap: onTap,
      ),
    );
  }
}
