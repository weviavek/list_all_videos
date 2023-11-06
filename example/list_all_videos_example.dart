import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideoListPage(
        title: 'List of Videos',
      ),
    );
  }
}

class VideoListPage extends StatelessWidget {
  final String title;
  const VideoListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ListAllVideos listVideosObject = ListAllVideos();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder(
            future: listVideosObject.getAllVideosPath(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          List<VideoDetails> videos = snapshot.data!;
                          return ListTile(
                            title: Text(videos[index].videoName),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )));
  }
}
