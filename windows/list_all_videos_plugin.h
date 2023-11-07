#ifndef FLUTTER_PLUGIN_LIST_ALL_VIDEOS_PLUGIN_H_
#define FLUTTER_PLUGIN_LIST_ALL_VIDEOS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace list_all_videos {

class ListAllVideosPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ListAllVideosPlugin();

  virtual ~ListAllVideosPlugin();

  // Disallow copy and assign.
  ListAllVideosPlugin(const ListAllVideosPlugin&) = delete;
  ListAllVideosPlugin& operator=(const ListAllVideosPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace list_all_videos

#endif  // FLUTTER_PLUGIN_LIST_ALL_VIDEOS_PLUGIN_H_
