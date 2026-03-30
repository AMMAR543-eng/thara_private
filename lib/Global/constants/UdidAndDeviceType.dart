import 'dart:io';
import 'package:thara/index/index_main.dart';

class ConstantsData {
  static String deviceType() {
    String os = Platform.operatingSystem; //in your code
    return os;
  }

  static Future<String?> udid() async {
    final deviceId = await PlatformDeviceId.getDeviceId ?? const Uuid().v4();
    return deviceId;
  }

  static Future<String?> firebaseToken() async {
    //  String? token = await FirebaseMessaging.instance.getToken();
    return "token";
  }
}
