import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

Future<bool> isDeviceCompromised() async {
  try {
    final jailbroken = await FlutterJailbreakDetection.jailbroken;
    final developerMode = await FlutterJailbreakDetection.developerMode;

    return jailbroken || developerMode;
  } catch (_) {
    return false; // fail-safe (ما تكسرش الابليكشن)
  }
}