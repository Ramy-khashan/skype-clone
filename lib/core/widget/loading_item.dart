import 'dart:io';

import 'package:flutter/material.dart'; 
import '../utils/app_color.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: AppColor.primary,
            )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
