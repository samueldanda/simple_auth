import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:root_jailbreak_detector/root_jailbreak_detector.dart';

Future<bool> checkDeviceIsSafe() async {
  return true;
  // locale.translate('dummy')

  /// ***************
  /// Root detection
  /// ***************
  final rootJailbreakDetectorPlugin = RootJailbreakDetector();
  bool root = false;
  bool jailbreak = false;
  try {
    if (Platform.isAndroid) {
      root = (await rootJailbreakDetectorPlugin.isRooted() ?? false);
    } else if (Platform.isIOS) {
      jailbreak = (await rootJailbreakDetectorPlugin.isJailbreaked() ?? false);
    }
  } on PlatformException {
    root = false;
    jailbreak = false;
  }

  if (root || jailbreak) {
    if (kDebugMode) {
      print('Device is rooted or jail broken');
    }
    return false;
  }
  else
    if (kDebugMode) {
      print('Device is not rooted or jail broken');
    }

  /// *******************
  /// Emulator detection
  /// *******************
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if (androidInfo.isPhysicalDevice == false) {
    if (kDebugMode) {
      print('Device is emulated or simulated');
    }
    return false; // Device is emulated or simulated
  }
  else
    if (kDebugMode) {
      print('Device is not emulated or simulated');
    }

  /// ****************************
  /// Developer options detection
  /// ****************************
  if (Platform.isAndroid) {
    const platform = MethodChannel('developer_options');
    try {
      bool enabled = await platform.invokeMethod('isDeveloperOptionsEnabled');
      if (enabled) {
        if (kDebugMode) {
          print('Developer options is enabled');
        }
        return false; // Developer options is enabled
      }
      else
        if (kDebugMode) {
          print('Developer options not is enabled');
        }
    } catch (e) {
      if (kDebugMode) {
        print('Developer options not is enabled ${e.toString()}');
      }
      return true;
    }
  }

  return true;
}
