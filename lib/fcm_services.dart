import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMServices {
  static var fcmserviceskey =
      'AAAAMcvDo7A:APA91bGqg7XKTH1qNI-UNyulMr3YjkAedg3YN77bsnAt203iRMy4BaiX1p6rEJ0yHfPlVg_LuRgSptu4B5sn5jHPvGDKB6soExASruAIq9IYaNWBfzpBqhFI5XScfFdzeVgoESfkHzMJ';
  // get device token
  static generateFCMToken() {
    try {
      FirebaseMessaging.instance.getToken().then((value) {
        print("Device Token:$value");
      });
    } catch (e) {
      print("Device Token e:$e");
    }
  }

  // listen onApp Fcm
  static listenAppFcm() {
    FirebaseMessaging.onMessage.listen((event) {
      print("OnApp FCM:$event");
      String title = event.notification!.title.toString();
      String body = event.notification!.body.toString();
      print(title);
      print(body);
      // display notification(title:title, body:body);
    });
  }

  // listen background FCM
  static listenbackgroundFCM(RemoteMessage message) {
    print("FCM message");
    var title = message.notification!.title;
    var body = message.notification!.body;
    // display notification(title:title.tostring(),body: body.tostring());
  }

  // create local notification()
  static displayNotification({required String title, required String body}) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ));
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails("", "",
                playSound: true,
                priority: Priority.high,
                importance: Importance.high,
                enableVibration: true)));
  }

  static sendFCMNotificatiopn() async {
    final responce = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'key=$fcmserviceskey'
      },
      body: jsonEncode({
        'to': '',
        'notification': {
          'title': '',
          'body': '',
        }
      }),
    );
  }
}
