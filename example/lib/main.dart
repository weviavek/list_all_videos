import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';

/// Main entry point for the application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the application, providing overall structure and theme.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// Home page of the application, displaying a list of videos with thumbnails.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ListAllVideos().getAllVideosPath(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Display list of videos with thumbnails
            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                leading: ThumbnailTile(
                  thumbnailController: snapshot.data![index].thumbnailController,
                ),
                title: Text(snapshot.data![index].videoName),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.length,
            );
          } else {
            // Display loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
