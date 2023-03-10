import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skype/core/services/server_locator.dart';

import 'skype_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serverLocator();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBILjgLb76psvxW0MSF5tui-t0jkqyMkMI",
      appId: "1:97075547990:android:d9396c6a541e646871d0f7",
      messagingSenderId: "97075547990",
      projectId: "skype-75d7a",
      storageBucket: "skype-75d7a.appspot.com",
    ),
  );

  runApp(const SkypeApp());
}
