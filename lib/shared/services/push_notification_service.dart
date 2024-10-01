import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
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
