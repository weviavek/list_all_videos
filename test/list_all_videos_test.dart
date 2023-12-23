import 'package:flutter/material.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Video List Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VideoList());
  }
}

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DemoList"),
      ),
      body: FutureBuilder(
        future: ListAllVideos().getAllVideosPath(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    VideoDetails currentVideo = snapshot.data![index];
                    return ListTile(
                        title: Text(currentVideo.videoName),
                        subtitle: Text(currentVideo.videoSize),
                        leading: ThumbnailTile(
                          thumbnailController: currentVideo.thumbnailController,
                          height: 80,
                          width: 150,
                        ));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length);
        },
      ),
    );
  }
}
