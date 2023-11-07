
This package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage. 

## Features

This will help you to list the path of all video files in locla storage

## Getting started

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
## Implementation
```dart
ListAllVideos object = ListAllVideos();
//lists all videos in the device. VideoDetails is a class to store video details such as video name, video size etc.
List<VideoDetails> videos = await object.getAllVideosPath();
```

## Additional information
The list_all_videos package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage. With a few simple lines of code, this package streamlines the process of accessing and organizing video file paths, making it easier to work with and display locally stored videos in your Flutter applications. Whether you're building a media player, video gallery, or any app that requires video file management, list_all_videos simplifies the task, saving you time and effort in the development process.