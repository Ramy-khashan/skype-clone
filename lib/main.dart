import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

class SkypeApp extends StatelessWidget {
  const SkypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {}, child: const Text("test Notification")),
        ),
      ),
    );
  }
}
