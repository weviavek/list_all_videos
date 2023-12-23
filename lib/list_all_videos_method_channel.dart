import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


/// An implementation of [ListAllVideosPlatform] that uses method channels.
class MethodChannelListAllVideos {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('list_all_videos');

  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
