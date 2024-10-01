import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    // 수신 메시지 listen
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Firebase 메세지 수신: ${message.notification?.title}");
      // if (onMessageReceived != null) {
      //   onMessageReceived!(message);
      // }
      // _showForegroundNotification(message);
    });

    // void _showForegroundNoti(BuildContext context, RemoteMessage message) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(message.notification?.title ?? 'Notification'),
    //         content:
    //             Text(message.notification?.body ?? 'You have a new message.'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Dismiss the dialog
    //             },
    //             child: const Text('Close'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    //   const DarwinInitializationSettings initializationSettingsIOS =
    //       DarwinInitializationSettings();

    //   const InitializationSettings initializationSettings =
    //       InitializationSettings(iOS: initializationSettingsIOS);
    //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // }

    // Future<void> _showForegroundNotification(RemoteMessage message) async {
    //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
    //     iOS: DarwinNotificationDetails(),
    //   );

    //   await flutterLocalNotificationsPlugin.show(
    //     0,
    //     message.notification?.title ?? 'No title',
    //     message.notification?.body ?? 'No body',
    //     platformChannelSpecifics,
    //   );
  }

  // Function(RemoteMessage message)? onMessageReceived;

  // void setOnMessageReceivedCallback(Function(RemoteMessage message) callback) {
  //   onMessageReceived = callback;
  // }

  static Future<String?> getDeviceToken() async {
    bool isRealDevice = await _isRealDevice();

    if (!isRealDevice) {
      debugPrint('Running on Simulator - FCM not supported');
      return null;
    }

    // 실기기일때만 실행
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      String? token = await messaging.getToken();
      if (token != null) {
        debugPrint('Device Token: $token');
      }
      return token;
    } catch (e) {
      debugPrint('Error getting device token: $e');
      return null;
    }
  }

  static Future<bool> _isRealDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      debugPrint('실기기 여부: ${iosInfo.isPhysicalDevice}');
      return iosInfo.isPhysicalDevice; // 실기기면 true, 시뮬이면 false
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice;
    }
    return true;
  }
}
