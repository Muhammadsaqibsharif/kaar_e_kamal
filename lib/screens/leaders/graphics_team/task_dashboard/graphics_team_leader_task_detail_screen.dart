import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GraphicsTeamLeaderTaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const GraphicsTeamLeaderTaskDetailScreen({super.key, required this.task});

  @override
  _GraphicsTeamLeaderTaskDetailScreenState createState() =>
      _GraphicsTeamLeaderTaskDetailScreenState();
}

class _GraphicsTeamLeaderTaskDetailScreenState
    extends State<GraphicsTeamLeaderTaskDetailScreen> {
  String taskStatus = 'Pending';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics Task Detail'),
        backgroundColor: theme.primaryColor,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task['title'],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: theme.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      "Due: ${widget.task['dueDate']}",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.task['description'],
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                if (widget.task['isUrgent'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.task['description']));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Description copied!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    child: const Text('Copy Description'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    children: [
                      const Text('Status: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
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
                          underline: Container(),
                          icon: Icon(Icons.arrow_drop_down, color: theme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Current Status: $taskStatus',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
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
