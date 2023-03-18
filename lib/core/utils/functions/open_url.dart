import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:url_launcher/url_launcher.dart';

onOpenUrl({required String url}) async {
  log(url);
  if (await canLaunch(url)) {
    try {
      await launch(url);
    } catch (e) {
      log(e.toString());
    }
  } else {
    appToast('Could not launch $url');
  }
}
