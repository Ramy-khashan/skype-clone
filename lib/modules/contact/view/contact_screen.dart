import 'package:flutter/material.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/functions/size_config.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => Column(
          children: [
            Card(
              color: Colors.grey.shade300,
              child: ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text("Ramy khashan"),
                  subtitle: Text("01011738586"),
                  onTap: () {},
                  trailing: FaIcon(FontAwesomeIcons.arrowRight)),
            ),
            SizedBox(height: index==14?getHeight(80):0,)
          ],
        ),
      ),
    );
  }
}
