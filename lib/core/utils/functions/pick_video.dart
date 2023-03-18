import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> getVideoPicker() async {
  XFile? xFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

  return File(xFile!.path);
}
