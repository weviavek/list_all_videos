import 'dart:io';
import 'generate_thumpnail.dart';

// A class to store video details
class VideoDetails {
  final String videoPath;
  late String videoName;
  late String videoSize;
  late ThumbnailController thumbnailController;

  VideoDetails(this.videoPath) {
    // Initialize video details
    videoName = VideoHelper.videoNameHelper(videoPath);
    videoSize = VideoHelper.videoSizeHelper(videoPath);
    thumbnailController = ThumbnailController(currentVideo: this);
  }
}

// A class to manage thumbnail generation and initialization
class ThumbnailController {
  late VideoDetails currentVideo;
  bool isInitialized = false;
  late String thumbnailPath;

  ThumbnailController({required this.currentVideo});

  // Asynchronously initialize the thumbnail
  Future<String> initThumbnail() async {
    if (isInitialized == false) {
      thumbnailPath = await Thumbnail().generate(currentVideo);
      isInitialized = true;
    }
    return thumbnailPath;
  }
}

// Helper class for working with video file details
class VideoHelper {
  // Calculate video file size and format it
  static String videoSizeHelper(String path) {
    int size = File(path).lengthSync();
    List<String> sizeNotations = ['bytes', 'KB', 'MB', 'GB'];
    int i = 0;
    while (size > 1024) {
      size = size ~/ 1024;
      i++;
    }
    return "$size ${sizeNotations[i]}";
  }

  // Extract video file name from its path
  static videoNameHelper(String videoPath) {
    final currentFile = File(videoPath);
    String parentPath = currentFile.parent.path;
    return videoPath.split('$parentPath/').last;
  }
}
