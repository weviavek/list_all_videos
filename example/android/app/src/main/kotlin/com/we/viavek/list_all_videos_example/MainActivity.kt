 package com.we.viavek.list_all_videos_example

 import android.graphics.Bitmap
 import android.media.MediaMetadataRetriever
 import io.flutter.embedding.android.FlutterActivity
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.MethodCall
 import io.flutter.plugin.common.MethodChannel
 import java.io.File
 import java.io.FileOutputStream

 class MainActivity: FlutterActivity() {

     private val channelName = "thumbnailGenerator"
     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)

         val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)


         channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
             if (call.method == "generate") {
                 val videoPath = call.argument<String>("videoPath")
                 val thumbnailLocation =call.argument<String>("thumbnailLocation")
                 val thumbnailName= videoPath?.let { File(it).name }
                 val generatedThumbnailPath =
                     thumbnailName?.let { generateThumbnail(videoPath!!, thumbnailLocation!!, it) }
                 result.success(generatedThumbnailPath)
             }
         }
     }
     fun generateThumbnail(videoPath: String, thumbnailLocation: String, thumbnailName: String): String {
         // Check if a thumbnail file already exists
         val existingThumbnailFile = File(thumbnailLocation, thumbnailName)
         if (existingThumbnailFile.exists()) {
             // Return the path of the existing thumbnail
             return existingThumbnailFile.absolutePath
         }

         // Create a MediaMetadataRetriever object.
         val mediaMetadataRetriever = MediaMetadataRetriever()
         mediaMetadataRetriever.setDataSource(videoPath)

         // Get the thumbnail of the video.
         val bitmap = mediaMetadataRetriever.frameAtTime

         // Create a new File object for the thumbnail.
         val thumbnailFile = File(thumbnailLocation, thumbnailName)

         // Write the thumbnail to the file.
         val outputStream = FileOutputStream(thumbnailFile)
         bitmap?.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
         outputStream.close()

         // Return the path of the generated thumbnail.
         return thumbnailFile.absolutePath
     }

 }
