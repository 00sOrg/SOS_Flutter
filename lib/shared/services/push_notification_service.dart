import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/utils/check_real_device.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // runApp 전에 부름
  Future<void> preAppInitialization() async {
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
    });
  }

  void postAppInitialization(BuildContext context, WidgetRef ref) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint(
            "(1)message.notification?.title: ${message.notification?.title}");
        debugPrint(
            "(1)message.notification?.body: ${message.notification?.body}");
        debugPrint("(1)message.data: ${message.data}");
        _handleNotificationTap(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          "(2)message.notification?.title: ${message.notification?.title}");
      debugPrint(
          "(2)message.notification?.body: ${message.notification?.body}");
      debugPrint("(2)message.data: ${message.data}");
      _handleNotificationTap(context, message);
    });
  }

  void _handleNotificationTap(BuildContext context, RemoteMessage message) {
    log('handleNotificationTap 눌림!!');
    if (message.data.containsKey('route')) {
      String route = message.data['route'];
      GoRouter.of(context).push(route);
    } else {
      GoRouter.of(context).push('/');
    }
  }

  static Future<String?> getDeviceToken() async {
    bool isRealDevice = await checkRealDevice();

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
}

final pushNotificationProvider = Provider((ref) => PushNotificationService());
