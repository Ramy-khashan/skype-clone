import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageVideoFirebase(
    {required File itemFile, required String folder}) async {
  int ranNum = Random().nextInt(10000000);
  String itemBasename = path.basename(itemFile.path) + ranNum.toString();

  var ref = FirebaseStorage.instance.ref().child("$folder/$itemBasename");
  await ref.putFile(
    File(itemFile.path),
  );
  return await ref.getDownloadURL();
}
