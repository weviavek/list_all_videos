import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Thumbnail {
  // **Method channel for communicating with the native platform**
  final MethodChannel _channel = const MethodChannel('thumbnailGenerator');

  // **Generates a thumbnail for a given video path**
  Future<String> generate(
    String videoPath,
  ) async {
    try {
      // **Get temporary directory for storing the generated thumbnail**
      final String thumbnailLocation = (await getTemporaryDirectory()).path;

      // **Invoke the platform-specific method to generate the thumbnail**
      final String generatedThumbnailPath = await _channel.invokeMethod(
        'generate',
        {
          'videoPath': videoPath,
          'thumbnailLocation': thumbnailLocation,
        },
      );

      // **Return the path of the generated thumbnail**
      return generatedThumbnailPath;
    } catch (e) {
      // **Handle any errors during thumbnail generation**
      throw 'Failed to generate thumbnail';
    }
  }
}
