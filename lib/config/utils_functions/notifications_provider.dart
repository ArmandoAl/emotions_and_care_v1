// // ignore_for_file: avoid_print

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationsProvider extends ChangeNotifier {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   String? token = '';

//   Future<void> init() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();

//     print('FCM Token: $fcmToken');
//     token = fcmToken;

//     initPushNotifications();
//   }

//   Future<void> handleMessage(RemoteMessage message) async {
//     print('Handling a background message $message');
//   }

//   void initPushNotifications() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       print('Message data: ${message.data}');
//     });
//   }
// }
