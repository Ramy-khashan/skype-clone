import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/core/utils/functions/size_config.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        
        itemCount: 15,
        itemBuilder: (context, index) => Column(
          children: [
            Card(  
            
              child: ListTile(
                leading: const CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d'),
                ),
                title: Text("Ramy khashan"),
                subtitle: Text("Missed Call"),
                onTap: () {},
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.jm().format(DateTime.now())),
                    GestureDetector(
                      onTap: (){
                        appToast("Coming soon");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.phone,
                      ),
                    )
                  ],
                ),
              ),
            ),
     SizedBox(height: index==14?getHeight(80):0,)
          ],
        ),
      ),
    );
  }
}
