import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  Future<void> _downloadImage(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/image.jpg');
      await file.writeAsBytes(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image downloaded!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permission denied!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _downloadImage(context),
          ),
        ],
      ),
      body: Center(
        child: InstaImageViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
