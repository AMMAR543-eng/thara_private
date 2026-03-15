import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart'; // ✅ updated
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../index/index_main.dart';

class DeviceService {
  final encrypt.Key key = encrypt.Key.fromUtf8(ApiConstatns.key_encryption);
  final encrypt.IV iv = encrypt.IV.fromUtf8(ApiConstatns.inv_encryption);

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, String>> getEncryptedHeaders() async {
    final deviceId = await PlatformDeviceId.getDeviceId ?? const Uuid().v4();
    final nowUtc = DateTime.now().toUtc().toIso8601String();

    Map<String, dynamic> deviceData = {};

    if (defaultTargetPlatform == TargetPlatform.android) {
      final info = await _deviceInfo.androidInfo;
      deviceData = {
        "model": info.model,
        "brand": info.brand,
        "version": info.version.release,
        "device": info.device,
        "manufacturer": info.manufacturer,
        "platform": "android",
      };
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final info = await _deviceInfo.iosInfo;
      deviceData = {
        "model": info.utsname.machine,
        "name": info.name,
        "systemVersion": info.systemVersion,
        "systemName": info.systemName,
        "platform": "ios",
      };
    }

    final combinedId = '$deviceId|||$nowUtc';
    final encryptedId = _encrypt(combinedId);
    final encryptedInfo = _encrypt(jsonEncode(deviceData));


    return {"X-DEVICE-ID": encryptedId, "X-DEVICE-INFO": encryptedInfo};
  }

  String _encrypt(String plainText) {
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }
}

class PlatformDeviceId {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String?> get getDeviceId async {
    try {
      if (kIsWeb) {
        return "web_device_${const Uuid().v4()}"; // fallback for web
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id; // ✅ updated (was `androidId` in old package)
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor;
      } else {
        return "unknown_device_${const Uuid().v4()}";
      }
    } on PlatformException {
      return null;
    }
  }
}
