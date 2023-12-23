// A class to manage thumbnail generation and initialization

import 'package:list_all_videos/thumbnail/generate_thumpnail.dart';

class ThumbnailController {
  // **Video path for which thumbnail needs to be generated**
  late String videoPath;

  // **Flag indicating whether the thumbnail is initialized**
  bool isInitialized = false;

  // **Path to the generated thumbnail image file**
  late String thumbnailPath;

  // **Constructor taking the video path as a required argument**
  ThumbnailController({required this.videoPath});

  // **Asynchronously initialize the thumbnail**
  //
  // This method checks if the thumbnail is already initialized.
  // If not, it generates the thumbnail using the provided video path and
  // stores the generated image path in the `thumbnailPath` variable.
  // Finally, it sets the `isInitialized` flag to true.
  Future<String> initThumbnail() async {
    if (isInitialized == false) {
      thumbnailPath = await Thumbnail().generate(videoPath);
      isInitialized = true;
    }
    return thumbnailPath;
  }
}
