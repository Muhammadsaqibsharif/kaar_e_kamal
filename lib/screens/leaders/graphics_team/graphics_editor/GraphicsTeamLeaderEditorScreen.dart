import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_painter/image_painter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';

class GraphicsTeamLeaderEditorScreen extends StatefulWidget {
  const GraphicsTeamLeaderEditorScreen({Key? key}) : super(key: key);

  @override
  State<GraphicsTeamLeaderEditorScreen> createState() =>
      _GraphicsTeamLeaderEditorScreenState();
}

class _GraphicsTeamLeaderEditorScreenState
    extends State<GraphicsTeamLeaderEditorScreen> {
  File? _imageFile;
  ImagePainterController? _controller;

  Future<void> _pickImage() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _controller = ImagePainterController();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied to access storage.")),
      );
    }
  }

  Future<void> _saveImage() async {
    if (_controller == null) return;

    final result = await _controller!.exportImage();

    if (result != null) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        await FlutterImageGallerySaver.saveImage(result);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image saved to gallery successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage permission denied.")),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphics Editor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
          if (_imageFile != null)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveImage,
            ),
        ],
      ),
      body: _imageFile == null
          ? const Center(
              child: Text(
                "Tap the image icon to pick a graphic to edit.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ImagePainter.file(
              _imageFile!,
              controller: _controller!,
              scalable: true,
              controlsAtTop: false,
            ),
    );
  }
}
