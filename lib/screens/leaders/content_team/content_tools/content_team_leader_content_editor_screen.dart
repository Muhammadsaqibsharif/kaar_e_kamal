import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentTeamLeaderContentEditorScreen extends StatefulWidget {
  const ContentTeamLeaderContentEditorScreen({Key? key}) : super(key: key);

  @override
  State<ContentTeamLeaderContentEditorScreen> createState() =>
      _ContentTeamLeaderContentEditorScreenState();
}

class _ContentTeamLeaderContentEditorScreenState
    extends State<ContentTeamLeaderContentEditorScreen> {
  final List<ContentItem> _contents = [
    ContentItem(title: 'Welcome Message', content: 'Welcome to our platform!'),
    ContentItem(
        title: 'Rules & Regulations',
        content: 'Please follow these guidelines...'),
  ];

  int _editorIndex = -1;
  final TextEditingController _editorController = TextEditingController();

  void _openEditor(int index) {
    setState(() {
      _editorIndex = index;
      _editorController.text = _contents[index].content;
    });
  }

  void _saveEditedContent() {
    if (_editorIndex >= 0) {
      setState(() {
        _contents[_editorIndex].content = _editorController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Content saved successfully')),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Content copied to clipboard')),
    );
  }

  void _navigateToAddContentScreen() async {
    final newContent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddContentScreen(),
      ),
    );

    if (newContent != null && newContent is ContentItem) {
      setState(() {
        _contents.insert(0, newContent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editorIndex >= 0;

    return WillPopScope(
      onWillPop: () async {
        if (isEditing) {
          _saveEditedContent();
          setState(() {
            _editorIndex = -1;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Content Editor"),
          actions: isEditing
              ? [
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      _saveEditedContent();
                      setState(() {
                        _editorIndex = -1;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(_editorController.text),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _saveEditedContent();
                      setState(() {
                        _editorIndex = -1;
                      });
                    },
                  ),
                ]
              : [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isEditing ? _buildEditor() : _buildContentList(),
        ),
        // ✅ FAB only shows when not editing
        floatingActionButton: isEditing
            ? null
            : FloatingActionButton(
                backgroundColor: const Color(0xFF859F3D),
                foregroundColor: Colors.black,
                onPressed: _navigateToAddContentScreen,
                child: const Icon(Icons.add),
              ),
      ),
    );
  }

  Widget _buildContentList() {
    return ListView.builder(
      itemCount: _contents.length,
      itemBuilder: (context, index) {
        final content = _contents[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(
              content.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              content.content.length > 60
                  ? '${content.content.substring(0, 60)}...'
                  : content.content,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            onTap: () => _openEditor(index),
          ),
        );
      },
    );
  }

  Widget _buildEditor() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: TextField(
            controller: _editorController,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: "Start writing content...",
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[800],
            ),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}

class ContentItem {
  String title;
  String content;

  ContentItem({required this.title, required this.content});
}

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({Key? key}) : super(key: key);

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveContent() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      Navigator.pop(
        context,
        ContentItem(title: title, content: content),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill both title and content")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Content"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveContent,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF859F3D),
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
