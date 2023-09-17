// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart'; 
// import 'package:skype/modules/calls/view/widgets/pickup_screen.dart';

// import '../../../../core/services/call_service/call_method/call_method.dart';
// import '../../../../core/services/call_service/model/call_model.dart';

// class PickupLayout extends StatelessWidget {
//   final Widget scaffold;
//   final CallMethod callMethods = CallMethod();

//   PickupLayout({super.key, 
//      required this.scaffold,
//   });

//   @override
//   Widget build(BuildContext context) { 

//     return (userProvider != null && userProvider.getUser != null)
//         ? StreamBuilder<DocumentSnapshot>(
//             stream: callMethods.callStream(uid: userProvider.getUser.uid),
//             builder: (context, snapshot) {
//               if (snapshot.hasData && snapshot.data!.data() != null) {
//                 Call call = Call.fromMap(snapshot.data!.data() as Map);

//                 if (!call.hasDialled!) {
//                   return PickupScreen(call: call);
//                 }
//               }
//               return scaffold;
//             },
//           )
//         : Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//   }
// }
