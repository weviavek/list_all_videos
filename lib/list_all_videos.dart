import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:async';
import 'model/video_model.dart';

// Entry point of the Dart program
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

// Class to list all video files on the device
class ListAllVideos {
  // List to store VideoDetails objects representing video file paths
  List<VideoDetails> videosDirectories = [];

  // List to store all directories found during the search
  List allDirectories = [];

  // List to store directories that may contain videos
  List myDirectories = [];

  // Index to keep track of the current position while iterating through directories
  int myIndex = 0;

  // Variable to store the Android version
  late int androidVersion;

  // Variable to store the status of video storage permission
  late PermissionStatus permissionStatus;

  // Asynchronous method to get all video files on the device
  Future<List<VideoDetails>> getAllVideosPath() async {
    // Object to get information about the Android device
    var androidInfo = DeviceInfoPlugin();

    try {
      // Get Android device information and extract the version
      await androidInfo.androidInfo.then((value) {
        androidVersion = int.parse(value.version.release);
      });
    } catch (e) {
      // Set Android version to 0 if information retrieval fails
      androidVersion = 0;
      throw ("Unsupported Android Version");
    }

    // Check Android version and request appropriate permissions
    if (androidVersion >= 13) {
      permissionStatus = await Permission.videos.request();
    } else {
      permissionStatus = await Permission.storage.request();
    }

    // Check if the permission is granted
    if (permissionStatus.isGranted) {
      myDirectories.clear();
      videosDirectories.clear();

      // Get a list of external storage directories
      List<Directory>? extDir = await getExternalStorageDirectories();
      List pathForCheck = [];

      // Iterate through external storage directories
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

      // Iterate through the paths for checking
      for (var pForCheck in pathForCheck) {
        Directory directory = Directory(pForCheck);

        // Check if the directory exists
        if (directory.statSync().type == FileSystemEntityType.directory) {
          var initialDirectories = directory.listSync().map((e) {
            return e.path;
          }).toList();

          // Iterate through the initial directories
          for (var directories in initialDirectories) {
            if (directories.toString().endsWith('.mp4')) {
              bool contains = false;
              // Add video details to the list
              for (final VideoDetails current in videosDirectories) {
                if (current.videoPath == directories) {
                  contains = true;
                }
              }
              if (!contains) videosDirectories.add(VideoDetails(directories));
            }
            if (!directories.toString().contains('.')) {
              // Add directory path to myDirectories list
              String dirs = "$directories/";
              myDirectories.add(dirs);
            }
          }
        }
      }
    }

    // Iterate through the directories in myDirectories list
    for (; myIndex < myDirectories.length; myIndex++) {
      var myDirs = Directory(myDirectories[myIndex]);

      // Check if the directory exists
      if (myDirs.statSync().type == FileSystemEntityType.directory) {
        if (!myDirs.toString().contains('Android')) {
          var initialDirectories = myDirs.listSync().map((e) {
            return e.path;
          }).toList();

          // Iterate through the initial directories
          for (var video in initialDirectories) {
            if (video.toString().endsWith('.mp4')) {
              // Add video details to the list
              bool contains = false;
              // Add video details to the list
              for (final VideoDetails current in videosDirectories) {
                if (current.videoPath == video) {
                  contains = true;
                }
              }
              if (!contains) videosDirectories.add(VideoDetails(video));
            }
          }

          // Iterate through the directories in the initial directories
          for (var directories in initialDirectories) {
            if (!directories.toString().contains('.') &&
                !directories.toString().contains('android') &&
                !directories.toString().contains('Android')) {
              String dirs = "$directories/";

              var tempDir = Directory(dirs);

              // Check if the directory exists and meets certain conditions
              if (!tempDir.toString().contains('.') &&
                  !tempDir.toString().contains('android') &&
                  !tempDir.toString().contains('Android')) {
                myDirectories.add(directories);
              }

              // Check if the directory is of type directory
              if (tempDir.statSync().type == FileSystemEntityType.directory) {
                if (!tempDir.toString().contains('/Android')) {
                  var videoDirs = tempDir.listSync().map((e) {
                    return e.path;
                  }).toList();

                  // Iterate through the video directories
                  for (var video in videoDirs) {
                    if (video.toString().endsWith('.mp4')) {
                      bool contains = false;
                      // Add video details to the list
                      for (final VideoDetails current in videosDirectories) {
                        if (current.videoPath == video) {
                          contains = true;
                        }
                      }
                      if (!contains) videosDirectories.add(VideoDetails(video));
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Return the list of VideoDetails objects

    videosDirectories
        .removeWhere((element) => element.videoName.startsWith('.'));
    return videosDirectories;
  }
}
