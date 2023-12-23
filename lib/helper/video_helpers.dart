// Helper class for working with video file details
import 'dart:io';

class VideoHelper {
  // **Calculate video file size and format it**
  //
  // This method takes a video path as input and returns a string
  // representing the file size in a human-readable format.
  static String videoSizeHelper(String path) {
    // Get the video file size
    int size = File(path).lengthSync();

    // Define a list of size notations (e.g., bytes, KB, MB, GB)
    List<String> sizeNotations = ['bytes', 'KB', 'MB', 'GB'];

    // Initialize loop counter
    int i = 0;

    // Convert size to human-readable format by dividing by 1024
    // until it is less than 1024 and incrementing the size notation index
    while (size > 1024) {
      size = size ~/ 1024;
      i++;
    }

    // Format the final size string with the appropriate notation
    return "$size ${sizeNotations[i]}";
  }

  // **Extract video file name from its path**
  //
  // This method takes a video path as input and returns a string
  // representing the filename without the path.
  static String videoNameHelper(String videoPath) {
    // Get the current video file object
    final currentFile = File(videoPath);

    // Extract the parent path of the video file
    String parentPath = currentFile.parent.path;

    // Split the video path by the parent path to obtain the filename
    return videoPath.split('$parentPath/').last;
  }
}
