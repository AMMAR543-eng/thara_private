import 'dart:math';
import 'package:crypto/crypto.dart';
import '../../../../index/index_main.dart';

class BiometricService {
  /// ✅ Authenticate using fingerprint/Face ID
  static Future<String?> authenticateAndGenerateToken() async {
    final localAuth = LocalAuthentication();
    final bool isSupported = await localAuth.isDeviceSupported();
    final bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (isSupported && canCheckBiometrics) {
      try {
        final didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Scan your fingerprint/Face ID to authenticate',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: true,
          ),
        );

        final availableBiometrics = await localAuth.getAvailableBiometrics();


        if (didAuthenticate) {
          // Generate a random secure token (e.g. SHA256 hash)
          final random = Random.secure();
          final bytes = List<int>.generate(32, (_) => random.nextInt(256));
          final token = sha256.convert(bytes).toString();

          return token; // 🔑 You can now send this to your use case
        }
      } on PlatformException catch (e) {
      }
    }
    return null;
  }
}
