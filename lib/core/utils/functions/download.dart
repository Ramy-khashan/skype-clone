import 'dart:io'; 
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
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/image.jpg');
  await file.writeAsBytes(bytes);

  

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
