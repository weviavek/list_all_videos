import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:async';
import 'generate_thumpnail.dart';

void main(List<String> args) async {
  // Create an object of the ListAllVideos class
  ListAllVideos object = ListAllVideos();

  // Get a list of video file paths and store it in the 'videos' variable
  List<VideoDetails> videos = await object.getAllVideosPath();

  // Iterate through the video paths and print them
  videos.map((currentPath) {
    print(currentPath);
  });
}

class ListAllVideos {
  List<VideoDetails> videosDirectories = [];
  List allDirectories = [];
  List myDirectories = [];
  int myIndex = 0;
  late int androidVersion;

  Future<List<VideoDetails>> getAllVideosPath() async {
    PermissionStatus status;
    var androidInfo = DeviceInfoPlugin();
    try {
      // Get Android device information and extract the version
      await androidInfo.androidInfo.then((value) {
        androidVersion = int.parse(value.version.release);
      });
    } catch (e) {
      androidVersion = 0;
      throw ("Unsupported Android Version");
    }

    // Check Android version and request appropriate permissions
    if (androidVersion >= 13) {
      status = await Permission.videos.request();
    } else {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      myDirectories.clear();
      videosDirectories.clear();

      // Get a list of external storage directories
      List<Directory>? extDir = await getExternalStorageDirectories();
      List pathForCheck = [];

      for (var paths in extDir!) {
        String path = paths.toString();
        String actualPath = path.substring(13, path.length - 1);
        int found = 0;
        int startIndex = 0;

        // Extract the relevant part of the path
        for (int pathIndex = actualPath.length - 1;
            pathIndex >= 0;
            pathIndex--) {
          if (actualPath[pathIndex] == "/") {
            found++;
            if (found == 4) {
              startIndex = pathIndex;
              break;
            }
          }
        }
        var splitPath = actualPath.substring(0, startIndex + 1);
        pathForCheck.add(splitPath);
      }

      for (var pForCheck in pathForCheck) {
        Directory directory = Directory(pForCheck);
        if (directory.statSync().type == FileSystemEntityType.directory) {
          var initialDirectories = directory.listSync().map((e) {
            return e.path;
          }).toList();

          for (var directories in initialDirectories) {
            if (directories.toString().endsWith('.mp4')) {
              videosDirectories.add(VideoDetails(directories));
            }
            if (!directories.toString().contains('.')) {
              String dirs = "$directories/";
              myDirectories.add(dirs);
            }
          }
        }
      }
    }

    for (; myIndex < myDirectories.length; myIndex++) {
      var myDirs = Directory(myDirectories[myIndex]);
      if (myDirs.statSync().type == FileSystemEntityType.directory) {
        if (!myDirs.toString().contains('Android')) {
          var initialDirectories = myDirs.listSync().map((e) {
            return e.path;
          }).toList();

          for (var video in initialDirectories) {
            if (video.toString().endsWith('.mp4')) {
              videosDirectories.add(VideoDetails(video));
            }
          }

          for (var directories in initialDirectories) {
            if (!directories.toString().contains('.') &&
                !directories.toString().contains('android') &&
                !directories.toString().contains('Android')) {
              String dirs = "$directories/";
              var tempDir = Directory(dirs);
              if (!tempDir.toString().contains('.') &&
                  !tempDir.toString().contains('android') &&
                  !tempDir.toString().contains('Android')) {
                myDirectories.add(directories);
              }

              if (tempDir.statSync().type == FileSystemEntityType.directory) {
                if (!tempDir.toString().contains('/Android')) {
                  var videoDirs = tempDir.listSync().map((e) {
                    return e.path;
                  }).toList();

                  for (var video in videoDirs) {
                    if (video.toString().endsWith('.mp4')) {
                      videosDirectories.add(VideoDetails(video));
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return videosDirectories;
  }
}

// A class to store video details
class VideoDetails {
  final String videoPath;
  late String videoName;
  late String videoSize;
  late ThumbnailController thumbnailController;

  VideoDetails(this.videoPath) {
    // Initialize video details
    videoName = VideoHelper.videoNameHelper(videoPath);
    videoSize = VideoHelper.videoSizeHelper(videoPath);
    thumbnailController = ThumbnailController(videoPath: this.videoPath);
  }
}

// A class to manage thumbnail generation and initialization
class ThumbnailController {
  late String videoPath;
  bool isInitialized = false;
  late String thumbnailPath;

  ThumbnailController({required this.videoPath});

  // Asynchronously initialize the thumbnail
  Future<String> initThumbnail() async {
    if (isInitialized == false) {
      thumbnailPath = await Thumbnail().generate(videoPath);
      isInitialized = true;
    }
    return thumbnailPath;
  }
}

// Helper class for working with video file details
class VideoHelper {
  // Calculate video file size and format it
  static String videoSizeHelper(String path) {
    int size = File(path).lengthSync();
    List<String> sizeNotations = ['bytes', 'KB', 'MB', 'GB'];
    int i = 0;
    while (size > 1024) {
      size = size ~/ 1024;
      i++;
    }
    return "$size ${sizeNotations[i]}";
  }

  // Extract video file name from its path
  static videoNameHelper(String videoPath) {
    final currentFile = File(videoPath);
    String parentPath = currentFile.parent.path;
    return videoPath.split('$parentPath/').last;
  }
}
