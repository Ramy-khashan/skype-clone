import 'dart:math'; 
import 'package:flutter/material.dart';
import '../../modules/chats/model/user_model.dart';

import '../../modules/calls/view/calls_screen.dart';
import '../services/call_service/call_method/call_method.dart';
import '../services/call_service/model/call_model.dart';

class CallUtils {
  static final CallMethod callMethods = CallMethod();

  static dial(
      {required UserModel callFrom,
      required UserModel callToo,
      context}) async {
    Call call = Call(
      callerId: callFrom.userid,
      callerName: callFrom.name,
      callerPic: callFrom.image,
      recieverId: callToo.userid,
      recieverName: callToo.name,
      recieverPic: callToo.image,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
