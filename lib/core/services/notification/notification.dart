// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService;
//   }

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService._internal();

//   Future<void> initNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@drawable/launch_background');

//     // const DarwinInitializationSettings initializationSettingsIOS =
//     //     DarwinInitializationSettings(
//     //   requestAlertPermission: false,
//     //   requestBadgePermission: false,
//     //   requestSoundPermission: false,
//     // );

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             // iOS: initializationSettingsIOS,
//             );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     );
//   }

//   Future<void> showNotification(
//       {required int id,
//       required String title,
//       required String body,
//       required int second}) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.now(tz.local)
//           .add(Duration(seconds:2 )),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'main_channel',
//           'Main Channel',
//           channelDescription: 'Main channel notifications',
//           importance: Importance.max,
//           priority: Priority.max,
//           icon: '@drawable/launch_background',
//           // ongoing: true,
//           //
//           // styleInformation: BigTextStyleInformation(''),
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle: true,
//     );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   Future<void> cancelNotification({required int id}) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }
// }
