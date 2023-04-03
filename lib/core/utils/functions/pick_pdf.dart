import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File> pickPdf() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc'],
  );
  log(result!.paths.toString());
  return File(result.paths[0]!);
}
