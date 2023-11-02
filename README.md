<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage. 

## Features

This will help you to list the path of all video files in locla storage

## Getting started

Add list_all_videos to dependencies in pubspec.yaml
```yaml
dependencies:
    list_all_videos: ^1.0.4
```
or
run following command in your terminal
```shell
flutter pub add list_all_videos
```
## Usage

```dart
ListAllVideos object = ListAllVideos();
List videos = await object.getAllVideosPath();
print(videos.length);
```

## Additional information
The list_all_videos package is a convenient and efficient tool for Flutter developers looking to list all video file paths stored in a user's local storage. With a few simple lines of code, this package streamlines the process of accessing and organizing video file paths, making it easier to work with and display locally stored videos in your Flutter applications. Whether you're building a media player, video gallery, or any app that requires video file management, list_all_videos simplifies the task, saving you time and effort in the development process.