import 'package:flutter/material.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        // height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: (context, index) => const Card(
                  color: AppColor.primary,
                  child: ListTile(
                      title: Text(
                    "lol",
                  ))),
            ),
            Positioned(
              bottom: 60,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: getWidth(35)),
                width: getWidth(300),
                height: getHeight(70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withOpacity(.75),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.home),
                    FloatingActionButton(
                      onPressed: () {},
                      shape: const CircleBorder(),
                      child: const Icon(Icons.phone),
                    ),
                    const Icon(Icons.home),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
