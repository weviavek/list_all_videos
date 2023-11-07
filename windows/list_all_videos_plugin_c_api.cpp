#include "include/list_all_videos/list_all_videos_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "list_all_videos_plugin.h"

void ListAllVideosPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  list_all_videos::ListAllVideosPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
