import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/server_locator.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'plala_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serverLocator();
   tz.initializeTimeZones();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: "AIzaSyBILjgLb76psvxW0MSF5tui-t0jkqyMkMI",
    //   appId: "1:97075547990:android:d9396c6a541e646871d0f7",
    //   messagingSenderId: "97075547990",
    //   projectId: "skype-75d7a",
    //   storageBucket: "skype-75d7a.appspot.com",
    // ),
  );

  runApp(const SkypeApp());
}
