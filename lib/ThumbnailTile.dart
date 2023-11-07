import 'dart:io';
import 'package:flutter/material.dart';
import 'video_model.dart';

// A widget to display a thumbnail image
class ThumbnailTile extends StatelessWidget {
  // Constructor for the ThumbnailTile
  const ThumbnailTile({
    this.height,
    this.width,
    super.key,
    required this.thumbnailController,
  });

  final ThumbnailController thumbnailController;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to asynchronously load the thumbnail image
    return FutureBuilder(
      future: thumbnailController.initThumbnail(),
      builder: (context, snapshot) => thumbnailController.isInitialized
          ? SizedBox(
              height: height,
              width: width,
              child: Image.file(
                File(thumbnailController.thumbnailPath),
                fit: BoxFit.cover,
              ),
            )
          : const CircularProgressIndicator(), // Display a loading indicator while initializing
    );
  }
}
