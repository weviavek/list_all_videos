import 'dart:io';

class VideoDetails {
  final String videoPath;
  late String videoName;
  late String videoSize;
  VideoDetails(this.videoPath) {
    videoName = VideoHelper.videoNameHelper(videoPath);
    videoSize = VideoHelper.videoSizeHelper(videoPath);
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
