import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

onDownloadItme({required String url, isDownload = false, context}) async {
  try {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;
    int random0 = Random().nextInt(7);
    int random1 = Random().nextInt(7);
    final directory = await getExternalStorageDirectory();
    var file = File('${directory!.path}/${random0}image$random1.png'); 
  file=  await file.writeAsBytes(bytes);
print(file.path);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image downloaded successfully'),
      ),
    );
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to download image'),
      ),
    );
  }
}
