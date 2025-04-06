import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Import for Clipboard functionality

class ContentTeamLeaderTaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const ContentTeamLeaderTaskDetailScreen({super.key, required this.task});

  @override
  _ContentTeamLeaderTaskDetailScreenState createState() =>
      _ContentTeamLeaderTaskDetailScreenState();
}

class _ContentTeamLeaderTaskDetailScreenState
    extends State<ContentTeamLeaderTaskDetailScreen> {
  String taskStatus = 'Pending'; // Default status

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        backgroundColor: theme.primaryColor, // Dark Green
        elevation: 4, // Adds shadow for a more polished look
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6, // Adds shadow to the card for a modern look
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of the task
                Text(
                  widget.task['title'],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor, // Dark Green
                  ),
                ),
                const SizedBox(height: 10),
                
                // Due date of the task
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: theme.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      "Due: ${widget.task['dueDate']}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color, // Light Color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Task description
                Text(
                  widget.task['description'],
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodyLarge?.color, // Light Color
                  ),
                ),
                const SizedBox(height: 20),

                // Urgent label if applicable
                if (widget.task['isUrgent'])
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "URGENT",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                // Copy to Clipboard button (Centered)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.task['description']));  // Copy the description to clipboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task description copied to clipboard!')),
                      );
                    },
                    child: const Text('Copy Description'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,  // Dark Green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),  // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Status Update Dropdown (Centered)
                Center(
                  child: Row(
                    children: [
                      const Text('Status: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.cardColor, // Light background color
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          value: taskStatus,
                          onChanged: (String? newStatus) {
                            setState(() {
                              taskStatus = newStatus!;
                            });
                          },
                          items: <String>['Pending', 'In Progress', 'Done']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          isExpanded: false,
                          underline: Container(), // Removes the underline for a cleaner look
                          icon: Icon(Icons.arrow_drop_down, color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Display the updated status (Centered)
                Center(
                  child: Text(
                    'Current Status: $taskStatus',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,  // Dark Green for status
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
