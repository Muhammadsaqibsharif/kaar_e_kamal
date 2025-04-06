import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskDetailsScreen extends StatelessWidget {
  static const String routeName = '/taskDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> task =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(task['taskName']),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoTile('Description', task['description']),
            _infoTile('Team', task['teamName']),
            _infoTile('Leader', task['leaderName']),
            _infoTile('Deadline', task['deadline'].toString().split(' ')[0]),
            _infoTile('Status', task['status']),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            const Text(
              'Output:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            task['status'] == 'Completed'
                ? _buildOutputWidget(
                    task['outputType'], task['output'], context)
                : Text(
                    '⏳ Task is still in progress or pending.',
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputWidget(
      String? type, dynamic output, BuildContext context) {
    switch (type) {
      case 'image':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _resolveImage(output),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _downloadImage(output, context);
              },
              icon: Icon(Icons.file_download),
              label: Center(child: Text("Download Image")),
            ),
          ],
        );
      case 'text':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(output, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: output));
              },
              icon: Icon(Icons.copy),
              label: Text("Copy Text"),
            ),
          ],
        );
      case 'file':
        return ElevatedButton.icon(
          onPressed: () => _launchURL(output),
          icon: Icon(Icons.file_download),
          label: Text("Download File"),
        );
      default:
        return Text("Unknown output type.");
    }
  }

  Widget _resolveImage(dynamic output) {
    if (output == null) {
      return Text("❌ No image available.");
    }

    try {
      final path = output.toString();

      // Handling asset images here, make sure the output is a valid image path
      return Image.asset(path, fit: BoxFit.cover, errorBuilder: (_, __, ___) {
        return Text("❌ Could not load asset image.");
      });
    } catch (e) {
      return Text("❌ Error loading image: $e");
    }
  }

  // Method to download and save the image to the gallery
  Future<void> _downloadImage(dynamic imagePath, BuildContext context) async {
    if (imagePath == null) {
      print("No image available to download.");
      return;
    }

    // Requesting storage permission
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (!permissionStatus.isGranted) {
      print("Storage permission not granted.");
      return;
    }

    try {
      final cacheManager = DefaultCacheManager();
      final url = imagePath.toString();

      // Download the image and store it locally
      final file = await cacheManager.getSingleFile(url);

      // Get a proper directory for storage
      final directory = await getExternalStorageDirectory();
      final path = directory?.path;

      if (path != null) {
        final localFile =
            File('$path/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.copy(localFile.path);
        print("Image downloaded to: ${localFile.path}");

        // Save the file to the gallery
        bool success = await GallerySaver.saveImage(localFile.path) ?? false;
        if (success) {
          print("Image saved to gallery.");

          // Show a success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Image saved to gallery!"),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print("Failed to save image to gallery.");
          // Show an error snackbar if the image saving failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to save image to gallery."),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print("Error downloading image: $e");

      // Show an error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to download image."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }
}
