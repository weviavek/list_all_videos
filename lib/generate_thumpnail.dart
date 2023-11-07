import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'video_model.dart';

class Thumbnail {
  final MethodChannel _channel = const MethodChannel('thumbnailGenerator');
  Future<String> generate(
    VideoDetails currentVideo,
  ) async {
    try {
      final String videoPath = currentVideo.videoPath;
      final String thumbnailLocation = (await getTemporaryDirectory()).path;

      final String generatedThumbnailPath =
          await _channel.invokeMethod('generate', {
        'videoPath': videoPath,
        'thumbnailLocation': thumbnailLocation,
      });
      //returns the path of generated thumbnail
      return generatedThumbnailPath;
    } catch (e) {
      throw 'Failed to generate thumbnail';
    }
  }
}
