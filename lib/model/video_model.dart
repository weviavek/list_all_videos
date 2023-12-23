import '../helper/video_helpers.dart';
import 'thumbnail_controller.dart';

// A class to store video details
class VideoDetails {
  // **Path to the video file**
  final String videoPath;

  // **Name of the video file**
  late String videoName;

  // **Size of the video file in a human-readable format**
  late String videoSize;

  // **Controller for generating and managing the video thumbnail**
  late ThumbnailController thumbnailController;

  // **Constructor taking the video path as a required argument**
  VideoDetails(this.videoPath) {
    // **Initialize video details:**
    //
    // 1. Extract video name using the `videoNameHelper` method from `VideoHelper`
    videoName = VideoHelper.videoNameHelper(videoPath);
    // 2. Calculate video size in a human-readable format using the `videoSizeHelper` method from `VideoHelper`
    videoSize = VideoHelper.videoSizeHelper(videoPath);
    // 3. Initialize a `ThumbnailController` object with the video path
    thumbnailController = ThumbnailController(videoPath: this.videoPath);
  }
}
