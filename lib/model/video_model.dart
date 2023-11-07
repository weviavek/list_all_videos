import 'dart:io';

import '../generate_thumpnail.dart';

class VideoDetails {
  final String videoPath;
  late String videoName;
  late String videoSize;
  late ThumbnailController thumbnailController;
  VideoDetails(this.videoPath) {
    videoName = VideoHelper.videoNameHelper(videoPath);
    videoSize = VideoHelper.videoSizeHelper(videoPath);
    thumbnailController = ThumbnailController(currentVideo: this);
  }
}

class ThumbnailController {
  late VideoDetails currentVideo;
  bool isInitialized = false;
  String? thumbnailPath;
  ThumbnailController({required this.currentVideo});
  Future<String> initThumbnail() async {
    if (isInitialized==false) {
      thumbnailPath = await Thumbnail().generate(currentVideo);
      isInitialized = true;
    }
    return thumbnailPath!;
  }
}

class VideoHelper {
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

  static videoNameHelper(String videoPath) {
    final currentFile = File(videoPath);
    String parentPath = currentFile.path;
    return videoPath.split(parentPath).last;
  }
}
