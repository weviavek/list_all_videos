import 'package:list_all_videos/list_all_videos.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () async {
    ListAllVideos object = ListAllVideos();
    List videos = await object.getAllVideosPath();
    print(videos.length);
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      ListAllVideos object = ListAllVideos();
      List videos = await object.getAllVideosPath();
      print(videos.length);
    });
  });
}
