import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; 

import '../../../../core/services/call_service/call_method/call_method.dart';
import '../../../../core/services/call_service/model/call_model.dart';
import '../calls_screen.dart';

class PickupScreen extends StatelessWidget {
  final Call call;
  final CallMethod callMethods = CallMethod();

  PickupScreen({
    super.key,
    required this.call,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            CircleAvatar(
              backgroundImage: NetworkImage(call.callerPic!),
              radius: 180,
            ),
            const SizedBox(height: 15),
            Text(
              call.callerName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                const SizedBox(width: 25),
                IconButton(
                  icon: const Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () async {
                    await [Permission.camera, Permission.microphone]
                        .request()
                        .then((value) {
                      print(value[Permission.camera]);
                      print(value[Permission.microphone]);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallScreen(call: call),
                      ),
                    );
                    });
                    
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
