import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkRealDevice() async {
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
