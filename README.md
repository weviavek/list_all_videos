
This package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage.
### 
* ThumbnailTile Added



## Features

This will help you to list the path of all video files in local storage

## Getting started

Add permission to your AndroidManifest.xml

for Android 12 and earlier 
```xml
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```
for Android 13 and later
```xml
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
```

Add list_all_videos to dependencies in pubspec.yaml
```yaml
dependencies:
    list_all_videos: ^1.0.9 
```
or
run following command in your terminal
```shell
    flutter pub add list_all_videos
```
## Usage

```dart
ListAllVideos object = ListAllVideos();
//lists all videos in the device
List<VideoDetails> videos = await object.getAllVideosPath();
```

## Using ThumbnailTile 
```dart
ThumbnailTile(
    thumbnailController: ThumbnailController('path_to_video')
    )
```
## Implementation
```dart

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
                          width: 100,
                        ));
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length);
        },
      ),
    );
  }
}
```

You may be using this [Medium story](https://medium.com/@we.viavek/list-video-files-in-local-storage-with-thumbnail-in-flutter-356d33bc1bfd) for more implementation details.

## Tips
```dart
    late List<VideoDetails> listOfVideos;
    ListAllVideos obj = ListAllVideos();
    obj.getAllVideos().then((value) {
        listOfVideos = value;
    });
    obj.permissionStatus;//returns the storage permission status.
    obj.androidVersion; // returns the android version.
```
###
* `permissionStatus` will be null until getAllVideos is called.
* Use `FutureBuilder` and call `getAllVideos()` in it.

## VideoDetails class
```dart
    VideoDetails sampleVideo = VideoDetails('path_to_video');
    sampleVideo.thumbnailController;
    sampleVideo.videoName; //Name of the video.
    sampleVideo.videoPath; //Path of the video in your storage.
    sampleVideo.videoSize; //Size of the video. 
```
## ThumbnailController
```dart
ThumbnailController thumbnailController = ThumbnailController(videoPath: 'path_to_video');
String thumbnailPath = await thumbnailController.initThumbnail(); // returns the path of generated thumbnail.
thumbnailController.isInitialized; // returns true if the thumbnail is generated.
thumbnailController.thumbnailPath; //returns the path of generated thumbnail
```
###
* ThumbnailController class can be used for generating thumbnail for any videos.
* initThumbnail() might be called to initilaze thumbnail.
* initThumbnail() might be called before using thumnailController.thumbanailPath.


## Additional information
The `list_all_videos` package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage. There is a seamless way to generate `thumbnail` of the video, making it easier to work with and display locally stored videos in your Flutter applications. Whether you're building a media player, video gallery, or any app that requires video file management, list_all_videos simplifies the task, saving you time and effort in the development process.