import 'dart:math';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skype/core/utils/functions/app_toast.dart';

onDownloadItme({required String url, isDownload = false, context}) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  if (statuses[Permission.storage]!.isGranted) {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
       int ranNum = Random().nextInt(10000000);
      String savename = "item$ranNum";
      String savePath = "${dir.path}/$savename";
      print(savePath);

      try {
        await Dio().download(url, savePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print("${(received / total * 100).toStringAsFixed(0)}%");
            //you can build progressbar feature too
          }
        });
        if (isDownload) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Download successfully")));
        }
        print("File is saved to download folder.");
      } on DioError catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed to download")));
      }
    }
  } else {
    print("No permission to read and write.");
    appToast("Failed to get permission");
  }
}
