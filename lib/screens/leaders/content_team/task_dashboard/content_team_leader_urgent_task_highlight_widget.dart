import 'package:flutter/material.dart';

class ContentTeamLeaderUrgentTaskHighlightWidget extends StatelessWidget {
  final String title;
  final String dueDate;
  final bool isUrgent;
  final String status; // Added status parameter

  const ContentTeamLeaderUrgentTaskHighlightWidget({
    super.key,
    required this.title,
    required this.dueDate,
    required this.isUrgent,
    required this.status, // Accept the status as a parameter
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: isUrgent ? Colors.red[100] : Colors.white,
        border: Border.all(
          color: isUrgent ? Colors.red : theme.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            isUrgent ? Icons.warning_amber_rounded : Icons.task_alt,
            color: isUrgent ? Colors.red : theme.primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor, // Dark Green
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Due: $dueDate',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.black, // Black color
                  ),
                ),
                const SizedBox(height: 4),
                // Display status here
                Text(
                  'Status: $status', // Show the status here
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
