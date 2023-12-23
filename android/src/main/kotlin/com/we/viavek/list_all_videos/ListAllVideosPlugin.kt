package com.we.viavek.list_all_videos

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import android.content.Context
import android.graphics.Bitmap
import android.media.MediaMetadataRetriever
import java.io.FileOutputStream

/** ListAllVideosPlugin */
class ListAllVideosPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "thumbnailGenerator")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "generate") {
      val videoPath = call.argument<String>("videoPath")
      val thumbnailLocation =call.argument<String>("thumbnailLocation")
      val thumbnailName=File(videoPath.toString()).name
      val generatedThumbnailPath = generateThumbnail(videoPath!!, thumbnailLocation!!,thumbnailName)
      result.success(generatedThumbnailPath)
  }
  }
  
  private fun generateThumbnail(videoPath: String, thumbnailLocation: String, thumbnailName: String): String {
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



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
